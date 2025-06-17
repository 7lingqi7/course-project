import sys
import numpy as np
import cv2
from skimage import exposure, restoration
from PySide6.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel, QPushButton, QFileDialog, QMessageBox, QHBoxLayout
from PySide6.QtGui import QImage, QPixmap
from PySide6.QtCore import Qt
from scipy.signal import convolve2d as conv2d
from skimage import restoration


class ImageProcessor2(QMainWindow):
    def __init__(self):
        super().__init__()
        self.original_image = None
        self.processed_image = None
        self.init_ui()

    def init_ui(self):
        self.setWindowTitle("Image Processing in Frequency Domain and Image Restoration")
        self.setGeometry(100, 100, 1200, 800)
        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)
        layout = QVBoxLayout(self.central_widget)

        # Image display setup
        self.image_layout = QHBoxLayout()
        self.original_image_label = QLabel("Original Image")
        self.original_image_label.setAlignment(Qt.AlignCenter)
        self.processed_image_label = QLabel("Processed Image")
        self.processed_image_label.setAlignment(Qt.AlignCenter)
        self.image_layout.addWidget(self.original_image_label)
        self.image_layout.addWidget(self.processed_image_label)
        layout.addLayout(self.image_layout)

        # Control buttons
        self.setup_buttons(layout)
        self.show()

    def setup_buttons(self, layout):
        buttons = {
            "Load Image": self.load_image,
            "FFT Magnitude and Phase": self.perform_fft,
            "Apply Ideal Lowpass Filter": self.apply_ideal_lowpass,
            "Apply Gaussian Lowpass Filter": self.apply_gaussian_lowpass,
            "Apply Butterworth Lowpass Filter": self.apply_butterworth_lowpass,
            "Apply Butterworth Highpass Filter": self.apply_butterworth_highpass,
            "Apply Adaptive Median Filter": self.apply_adaptive_median,
            "Apply Motion Blur and Restore": self.apply_motion_blur
        }
        for text, function in buttons.items():
            btn = QPushButton(text)
            btn.clicked.connect(function)
            layout.addWidget(btn)

    def load_image(self):
        file_path, _ = QFileDialog.getOpenFileName(self, "Open Image", "", "Image Files (*.png *.jpg *.jpeg *.bmp)")
        if file_path:
            self.original_image = cv2.imread(file_path, cv2.IMREAD_GRAYSCALE)
            self.processed_image = self.original_image.copy()
            self.display_image(self.original_image, self.original_image_label)

    def perform_fft(self):
        if self.original_image is not None:
            fft = np.fft.fft2(self.original_image)
            fft_shift = np.fft.fftshift(fft)
            magnitude = np.log(np.abs(fft_shift) + 1)
            self.display_image(magnitude, self.processed_image_label)  # Displaying magnitude for visibility

    def apply_ideal_lowpass(self):
        if self.original_image is not None:
            fft = np.fft.fft2(self.original_image)
            fft_shift = np.fft.fftshift(fft)
            rows, cols = self.original_image.shape
            center_row, center_col = rows // 2, cols // 2
            radius = 50  # Define radius for low pass
            mask = np.zeros((rows, cols), np.uint8)
            cv2.circle(mask, (center_col, center_row), radius, 1, -1)
            filtered_fft_shift = fft_shift * mask
            fft_ishift = np.fft.ifftshift(filtered_fft_shift)
            img_back = np.fft.ifft2(fft_ishift)
            self.display_image(np.abs(img_back), self.processed_image_label)

    def apply_gaussian_lowpass(self):
        if self.original_image is not None:
            fft = np.fft.fft2(self.original_image)
            fft_shift = np.fft.fftshift(fft)
            rows, cols = self.original_image.shape
            center_row, center_col = rows // 2, cols // 2
            sigma = 10  # Example sigma
            x = np.linspace(-center_col, center_col, cols)
            y = np.linspace(-center_row, center_row, rows)
            x, y = np.meshgrid(x, y)
            mask = np.exp(-((x ** 2 + y ** 2) / (2 * sigma ** 2)))
            filtered_fft_shift = fft_shift * mask
            fft_ishift = np.fft.ifftshift(filtered_fft_shift)
            img_back = np.fft.ifft2(fft_ishift)
            self.display_image(np.abs(img_back), self.processed_image_label)

    def butterworth_lowpass_filter(self, dims, cutoff, order):
        rows, cols = dims
        r, c = np.mgrid[:rows, :cols]
        c -= cols // 2
        r -= rows // 2
        distance = np.sqrt(c ** 2 + r ** 2)
        return 1 / (1 + (distance / cutoff) ** (2 * order))

    def apply_butterworth_lowpass(self):
        if self.original_image is not None:
            fft = np.fft.fft2(self.original_image)
            fft_shift = np.fft.fftshift(fft)
            dims = self.original_image.shape
            cutoff = 50  # Example cutoff frequency
            order = 2  # Example order
            bl_filter = self.butterworth_lowpass_filter(dims, cutoff, order)
            filtered_fft_shift = fft_shift * bl_filter
            fft_ishift = np.fft.ifftshift(filtered_fft_shift)
            img_back = np.fft.ifft2(fft_ishift)
            self.processed_image = np.abs(img_back)
            self.display_image(self.processed_image, self.processed_image_label)

    def apply_butterworth_highpass(self):
        if self.original_image is not None:
            fft = np.fft.fft2(self.original_image)
            fft_shift = np.fft.fftshift(fft)
            dims = self.original_image.shape
            cutoff = 50  # Example cutoff frequency
            order = 2  # Example order
            bl_filter = self.butterworth_lowpass_filter(dims, cutoff, order)
            bh_filter = 1 - bl_filter  # Invert lowpass to create highpass
            filtered_fft_shift = fft_shift * bh_filter
            fft_ishift = np.fft.ifftshift(filtered_fft_shift)
            img_back = np.fft.ifft2(fft_ishift)
            self.processed_image = np.abs(img_back)
            self.display_image(self.processed_image, self.processed_image_label)

    def motion_blur(self, image, kernel_size=15):
        # Assuming a simple motion blur along the horizontal axis
        kernel = np.zeros((1, kernel_size))
        kernel[0, :] = np.ones(kernel_size) / kernel_size
        image_blurred = cv2.filter2D(image, -1, kernel)
        return image_blurred

    def apply_motion_blur(self):
        if self.original_image is not None:
            self.processed_image = self.motion_blur(self.original_image)
            self.display_image(self.processed_image, self.processed_image_label)

    def adaptive_median_filter(self, image, max_window_size=7):
        img = image.copy()
        rows, cols = img.shape

        def median_filter(img, kernel_size):
            pad_size = kernel_size // 2
            padded_img = np.pad(img, pad_size, mode='constant', constant_values=0)
            new_img = np.zeros_like(img)
            for i in range(img.shape[0]):
                for j in range(img.shape[1]):
                    local_region = padded_img[i:i + kernel_size, j:j + kernel_size]
                    new_img[i, j] = np.median(local_region)
            return new_img

        filtered_image = np.zeros_like(img)
        for i in range(rows):
            for j in range(cols):
                window_size = 3
                while window_size <= max_window_size:
                    start_i = max(i - window_size // 2, 0)
                    end_i = min(i + window_size // 2 + 1, rows)
                    start_j = max(j - window_size // 2, 0)
                    end_j = min(j + window_size // 2 + 1, cols)
                    window = img[start_i:end_i, start_j:end_j]
                    med = np.median(window)
                    max_val = np.max(window)
                    min_val = np.min(window)
                    if min_val < med < max_val:
                        filtered_image[i, j] = img[i, j] if min_val < img[i, j] < max_val else med
                        break
                    window_size += 2
                    if window_size > max_window_size:
                        filtered_image[i, j] = med
        return filtered_image

    def apply_adaptive_median(self):
        if self.original_image is not None:
            self.processed_image = self.adaptive_median_filter(self.original_image)
            self.display_image(self.processed_image, self.processed_image_label)

    def display_image(self, image, label):
        # Check if the image is complex and convert to magnitude if so
        if np.issubdtype(image.dtype, np.complexfloating):
            image = np.abs(image)

        # Convert the image to float to prevent casting errors during normalization
        if image.dtype != np.float64:
            image = image.astype(np.float64)

        # Normalize the image to the range 0-1
        image -= np.min(image)
        if np.max(image) != 0:
            image /= np.max(image)

        # Convert to 8-bit image after normalization
        image_display = (image * 255).astype(np.uint8)

        # Ensure image data is contiguous in memory, required by QImage
        image_display = np.ascontiguousarray(image_display)

        # Create QImage from the image data
        q_img = QImage(image_display.data, image_display.shape[1], image_display.shape[0], image_display.strides[0],
                       QImage.Format_Grayscale8)
        pixmap = QPixmap.fromImage(q_img)
        label.setPixmap(pixmap.scaled(400, 300, Qt.KeepAspectRatio, Qt.SmoothTransformation))


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ImageProcessor2()
    sys.exit(app.exec_())
