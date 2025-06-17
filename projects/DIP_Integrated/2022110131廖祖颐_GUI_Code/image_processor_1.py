import sys
import numpy as np
from skimage import io, exposure, img_as_ubyte
from skimage.color import rgb2gray
from PySide6.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel, QPushButton, QFileDialog, QMessageBox, QHBoxLayout, QSlider, QGroupBox, QGridLayout)
from PySide6.QtGui import QImage, QPixmap
from PySide6.QtCore import Qt
from matplotlib.backends.backend_qtagg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure

class ImageIntensityProcessor(QMainWindow):
    def __init__(self):
        super().__init__()
        self.original_image = None
        self.processed_image = None
        self.init_ui()

    def init_ui(self):
        self.setWindowTitle("Image Intensity Transformations and Spatial Filtering")
        self.setGeometry(100, 100, 1000, 800)  # Increased size for better layout
        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)
        layout = QVBoxLayout(self.central_widget)

        # Image display setup
        self.image_layout = QHBoxLayout()
        self.original_image_label = QLabel("Original Image")
        self.original_image_label.setAlignment(Qt.AlignCenter)
        self.original_image_label.setMinimumSize(400, 300)  # Ensuring minimum size
        self.processed_image_label = QLabel("Processed Image")
        self.processed_image_label.setAlignment(Qt.AlignCenter)
        self.processed_image_label.setMinimumSize(400, 300)  # Ensuring minimum size
        self.image_layout.addWidget(self.original_image_label)
        self.image_layout.addWidget(self.processed_image_label)
        layout.addLayout(self.image_layout)

        # Histogram display setup
        self.histogram_layout = QVBoxLayout()
        self.histogram_canvas = FigureCanvas(Figure(figsize=(5, 2)))
        self.histogram_ax = self.histogram_canvas.figure.subplots()
        self.histogram_layout.addWidget(self.histogram_canvas)
        layout.addLayout(self.histogram_layout, 1)  # Adding stretch factor to give it more space

        # Control buttons
        self.controls_layout = QHBoxLayout()
        self.btn_load = QPushButton("Load Image")
        self.btn_load.clicked.connect(self.load_image)
        self.controls_layout.addWidget(self.btn_load)

        self.btn_convert_grayscale = QPushButton("Convert to Grayscale")
        self.btn_convert_grayscale.clicked.connect(self.convert_to_grayscale)
        self.controls_layout.addWidget(self.btn_convert_grayscale)

        self.btn_save = QPushButton("Save Image")
        self.btn_save.clicked.connect(self.save_image)
        self.controls_layout.addWidget(self.btn_save)

        self.btn_reset = QPushButton("Reset Image")
        self.btn_reset.clicked.connect(self.reset_image)
        self.controls_layout.addWidget(self.btn_reset)

        layout.addLayout(self.controls_layout)

        # Contrast and Histogram adjustments
        self.setup_contrast_and_histogram_controls(layout)

        self.show()

    def setup_contrast_and_histogram_controls(self, layout):
        control_group = QGroupBox("Image Adjustments")
        control_layout = QGridLayout()

        # Buttons for contrast adjustments
        self.btn_stretch = QPushButton("Stretch Grayscale [0,1]")
        self.btn_stretch.clicked.connect(lambda: self.adjust_contrast(0, 1))
        control_layout.addWidget(self.btn_stretch, 0, 0)

        self.btn_shrink = QPushButton("Shrink Grayscale [0.2,0.8]")
        self.btn_shrink.clicked.connect(lambda: self.adjust_contrast(0.2, 0.8))
        control_layout.addWidget(self.btn_shrink, 0, 1)

        self.btn_negative = QPushButton("Negative Image")
        self.btn_negative.clicked.connect(self.negative_image)
        control_layout.addWidget(self.btn_negative, 1, 0)

        self.btn_log = QPushButton("Log Transformation")
        self.btn_log.clicked.connect(self.log_transform)
        control_layout.addWidget(self.btn_log, 1, 1)

        # Gamma adjustment
        self.gamma_slider = QSlider(Qt.Horizontal)
        self.gamma_slider.setMinimum(5)
        self.gamma_slider.setMaximum(15)
        self.gamma_slider.setValue(10)  # Default gamma = 1.0
        self.gamma_slider.setTickInterval(1)
        self.gamma_slider.valueChanged.connect(self.gamma_transform)
        control_layout.addWidget(QLabel("Gamma:"), 2, 0)
        control_layout.addWidget(self.gamma_slider, 2, 1)

        self.btn_equalize_hist = QPushButton("Equalize Histogram")
        self.btn_equalize_hist.clicked.connect(self.equalize_histogram)
        control_layout.addWidget(self.btn_equalize_hist, 3, 0)

        control_group.setLayout(control_layout)
        layout.addWidget(control_group)

    def load_image(self):
        file_path, _ = QFileDialog.getOpenFileName(self, "Open Image", "", "Image Files (*.png *.jpg *.jpeg *.bmp)")
        if file_path:
            self.original_image = io.imread(file_path)
            self.processed_image = self.original_image.copy()
            self.display_image(self.original_image, self.original_image_label)
            # Only show histogram if the image is grayscale
            if self.original_image.ndim == 2 or self.processed_image.ndim == 2:
                self.update_histogram(self.processed_image)

    def convert_to_grayscale(self):
        if self.original_image is not None and self.original_image.ndim == 3:
            self.processed_image = rgb2gray(self.original_image)
            self.display_image(self.processed_image, self.processed_image_label)
            self.update_histogram(self.processed_image)

    def reset_image(self):
        if self.original_image is not None:
            self.processed_image = self.original_image.copy()
            self.display_image(self.processed_image, self.processed_image_label)
            if self.processed_image.ndim == 2:
                self.update_histogram(self.processed_image)

    def save_image(self):
        if self.processed_image is not None:
            save_path, _ = QFileDialog.getSaveFileName(self, "Save Image", "", "JPEG Files (*.jpg);;PNG Files (*.png)")
            if save_path:
                io.imsave(save_path, img_as_ubyte(self.processed_image))
                QMessageBox.information(self, "Save Image", "Image successfully saved!")

    def adjust_contrast(self, min_val, max_val):
        if self.processed_image is not None:
            self.processed_image = exposure.rescale_intensity(self.processed_image, out_range=(min_val, max_val))
            self.display_image(self.processed_image, self.processed_image_label)
            self.update_histogram(self.processed_image)

    def negative_image(self):
        if self.processed_image is not None:
            self.processed_image = 1 - self.processed_image
            self.display_image(self.processed_image, self.processed_image_label)
            self.update_histogram(self.processed_image)

    def log_transform(self):
        if self.processed_image is not None:
            self.processed_image = exposure.adjust_log(self.processed_image, gain=1)
            self.display_image(self.processed_image, self.processed_image_label)
            self.update_histogram(self.processed_image)

    def gamma_transform(self):
        if self.processed_image is not None:
            gamma_value = self.gamma_slider.value() / 10.0
            self.processed_image = exposure.adjust_gamma(self.processed_image, gamma=gamma_value)
            self.display_image(self.processed_image, self.processed_image_label)
            self.update_histogram(self.processed_image)

    def equalize_histogram(self):
        if self.processed_image is not None:
            self.processed_image = exposure.equalize_hist(self.processed_image)
            self.display_image(self.processed_image, self.processed_image_label)
            self.update_histogram(self.processed_image)

    def display_image(self, image, label):
        if image.ndim == 2:  # Grayscale image
            image_display = (image * 255).astype(np.uint8)
        else:  # Color image
            image_display = image
        q_img = QImage(image_display.data, image_display.shape[1], image_display.shape[0], QImage.Format_Grayscale8 if image.ndim == 2 else QImage.Format_RGB888)
        pixmap = QPixmap.fromImage(q_img)
        label.setPixmap(pixmap.scaled(400, 300, Qt.KeepAspectRatio))

    def update_histogram(self, image):
        self.histogram_ax.clear()
        self.histogram_ax.hist(image.ravel(), bins=256, range=[0, 1], histtype='stepfilled', alpha=0.3, color='gray')
        self.histogram_ax.set_title('Image Histogram')
        self.histogram_ax.set_xlim([0, 1])
        self.histogram_canvas.draw()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ImageIntensityProcessor()
    sys.exit(app.exec_())
