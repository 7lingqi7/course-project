import sys
import numpy as np
import cv2
from skimage import io, util
from PySide6.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel, QPushButton, QFileDialog, QMessageBox, QHBoxLayout, QSlider, QLineEdit, QFormLayout, QGroupBox, QComboBox)
from PySide6.QtGui import QImage, QPixmap
from PySide6.QtCore import Qt

class ImageProcessor(QMainWindow):
    def __init__(self):
        super().__init__()
        self.original_image = None
        self.processed_image = None
        self.init_ui()

    def init_ui(self):
        self.setWindowTitle("Advanced Image Processor")
        self.setGeometry(100, 100, 1200, 600)
        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)
        self.layout = QVBoxLayout(self.central_widget)

        self.setup_image_views()
        self.setup_controls()

    def setup_image_views(self):
        self.image_layout = QHBoxLayout()

        self.original_image_label = QLabel("Original Image")
        self.original_image_label.setAlignment(Qt.AlignCenter)
        self.image_layout.addWidget(self.original_image_label)

        self.processed_image_label = QLabel("Processed Image")
        self.processed_image_label.setAlignment(Qt.AlignCenter)
        self.image_layout.addWidget(self.processed_image_label)

        self.layout.addLayout(self.image_layout)

    def setup_controls(self):
        control_group = QGroupBox("Controls")
        control_layout = QVBoxLayout()

        self.btn_load = QPushButton("Load Image")
        self.btn_load.clicked.connect(self.load_image)
        control_layout.addWidget(self.btn_load)

        self.btn_save = QPushButton("Save Image")
        self.btn_save.clicked.connect(self.save_image)
        control_layout.addWidget(self.btn_save)

        self.btn_reset = QPushButton("Reset Image")
        self.btn_reset.clicked.connect(self.reset_image)
        control_layout.addWidget(self.btn_reset)

        # Cropping controls
        self.crop_form = QFormLayout()
        self.x_input = QLineEdit()
        self.y_input = QLineEdit()
        self.crop_form.addRow("Center X:", self.x_input)
        self.crop_form.addRow("Center Y:", self.y_input)
        self.btn_crop_center = QPushButton("Crop Center")
        self.btn_crop_center.clicked.connect(self.crop_center)
        self.crop_form.addRow(self.btn_crop_center)
        control_layout.addLayout(self.crop_form)

        # Other buttons
        self.btn_gray_scale = QPushButton("Convert to Weighted Grayscale")
        self.btn_gray_scale.clicked.connect(self.convert_to_gray_scale)
        control_layout.addWidget(self.btn_gray_scale)

        self.btn_add_noise = QPushButton("Add Noise")
        self.btn_add_noise.clicked.connect(lambda: self.add_noise('gaussian'))
        control_layout.addWidget(self.btn_add_noise)

        self.btn_apply_mask = QPushButton("Apply Circular Mask")
        self.btn_apply_mask.clicked.connect(self.apply_mask)
        control_layout.addWidget(self.btn_apply_mask)

        # Noise Reduction Controls
        self.noise_reduction_method = QComboBox()
        self.noise_reduction_method.addItems(["Gaussian Blur", "Median Filter"])
        control_layout.addWidget(self.noise_reduction_method)

        self.btn_reduce_noise = QPushButton("Reduce Noise")
        self.btn_reduce_noise.clicked.connect(self.reduce_noise)
        control_layout.addWidget(self.btn_reduce_noise)

        control_group.setLayout(control_layout)
        self.layout.addWidget(control_group)

    def load_image(self):
        file_name, _ = QFileDialog.getOpenFileName(self, "Open Image", "", "Image Files (*.png *.jpg *.bmp *.tiff)")
        if file_name:
            self.original_image = cv2.imread(file_name)
            self.processed_image = np.copy(self.original_image)
            self.display_image(self.original_image, self.original_image_label)
            self.display_image(self.processed_image, self.processed_image_label)

    def save_image(self):
        if self.processed_image is not None:
            save_path, _ = QFileDialog.getSaveFileName(self, "Save Image", "", "JPEG Files (*.jpg);;PNG Files (*.png)")
            if save_path:
                cv2.imwrite(save_path, self.processed_image)
                QMessageBox.information(self, "Save Image", "Image successfully saved!")

    def reset_image(self):
        if self.original_image is not None:
            self.processed_image = np.copy(self.original_image)
            self.display_image(self.processed_image, self.processed_image_label)

    def display_image(self, image, label):
        if image is not None and image.size != 0:
            image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            height, width, channel = image_rgb.shape
            bytesPerLine = 3 * width
            qImg = QImage(image_rgb.data, width, height, bytesPerLine, QImage.Format_RGB888)
            pixmap = QPixmap.fromImage(qImg)
            label.setPixmap(pixmap.scaled(560, 420, Qt.KeepAspectRatio))

    def crop_center(self):
        try:
            x = int(self.x_input.text())
            y = int(self.y_input.text())
            size_height = 128
            size_width = 128
            x_start = max(0, x - size_width // 2)
            y_start = max(0, y - size_height // 2)
            cropped_image = self.processed_image[y_start:y_start + size_height, x_start:x_start + size_width]
            self.processed_image = cropped_image
            self.display_image(self.processed_image, self.processed_image_label)
        except Exception as e:
            QMessageBox.critical(self, "Error", "Invalid cropping parameters or image not loaded.")

    def convert_to_gray_scale(self):
        if self.processed_image is not None:
            R, G, B = cv2.split(self.processed_image)
            gray_weighted_image = (0.30 * R + 0.59 * G + 0.11 * B).astype(np.uint8)
            self.processed_image = cv2.merge([gray_weighted_image, gray_weighted_image, gray_weighted_image])
            self.display_image(self.processed_image, self.processed_image_label)

    def add_noise(self, mode):
        if self.processed_image is not None:
            noisy_image = util.random_noise(self.processed_image, mode=mode)
            noisy_image_uint8 = (noisy_image * 255).astype(np.uint8)
            self.processed_image = noisy_image_uint8
            self.display_image(self.processed_image, self.processed_image_label)

    def apply_mask(self):
        if self.processed_image is not None:
            height, width, _ = self.processed_image.shape
            x, y = np.ogrid[0:height, 0:width]
            mask = (x - height // 2) ** 2 + (y - width // 2) ** 2 > (height * width // 4)
            self.processed_image[mask] = 0
            self.display_image(self.processed_image, self.processed_image_label)

    def reduce_noise(self):
        if self.processed_image is not None:
            selected_method = self.noise_reduction_method.currentText()
            if selected_method == "Gaussian Blur":
                self.processed_image = cv2.GaussianBlur(self.processed_image, (5, 5), 0)
            elif selected_method == "Median Filter":
                self.processed_image = cv2.medianBlur(self.processed_image, 5)
            self.display_image(self.processed_image, self.processed_image_label)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    ex = ImageProcessor()
    ex.show()
    sys.exit(app.exec())