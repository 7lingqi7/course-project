import sys
import numpy as np
from skimage import io, morphology, color, filters, feature
from PySide6.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel, QPushButton, QFileDialog, QHBoxLayout, QMessageBox
from PySide6.QtGui import QImage, QPixmap
from PySide6.QtCore import Qt

class ImageProcessor3(QMainWindow):
    def __init__(self):
        super().__init__()
        self.original_image = None
        self.binary_image = None
        self.init_ui()

    def init_ui(self):
        self.setWindowTitle("Image Processing - Morphological Operations")
        self.setGeometry(100, 100, 1200, 600)
        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)
        layout = QVBoxLayout(self.central_widget)

        self.image_layout = QHBoxLayout()
        self.original_image_label = QLabel("Original Image")
        self.original_image_label.setAlignment(Qt.AlignCenter)
        self.processed_image_label = QLabel("Processed Image")
        self.processed_image_label.setAlignment(Qt.AlignCenter)
        self.image_layout.addWidget(self.original_image_label)
        self.image_layout.addWidget(self.processed_image_label)
        layout.addLayout(self.image_layout)

        self.setup_buttons(layout)
        self.show()

    def setup_buttons(self, layout):
        buttons = {
            "Load Image": self.load_image,
            "Boundary Extraction": self.apply_boundary_extraction,
            "Edge Detection": self.apply_edge_detection,
            "Erosion": lambda: self.apply_morphological_operation(morphology.binary_erosion),
            "Dilation": lambda: self.apply_morphological_operation(morphology.binary_dilation)
        }
        for text, function in buttons.items():
            btn = QPushButton(text)
            btn.clicked.connect(function)
            layout.addWidget(btn)

    def load_image(self):
        file_path, _ = QFileDialog.getOpenFileName(self, "Open Image", "", "Image Files (*.png *.jpg *.jpeg *.bmp)")
        if file_path:
            self.original_image = color.rgb2gray(io.imread(file_path))
            self.binary_image = self.original_image > 0.5  # Simple thresholding
            self.display_image(self.binary_image, self.original_image_label)

    def apply_morphological_operation(self, operation):
        if self.binary_image is not None:
            se = morphology.square(3)  # Use a simple square structuring element
            processed_image = operation(self.binary_image, se)
            self.display_image(processed_image, self.processed_image_label)

    def apply_boundary_extraction(self):
        if self.binary_image is not None:
            se = morphology.square(3)
            eroded_image = morphology.binary_erosion(self.binary_image, se)
            boundary = self.binary_image & ~eroded_image
            self.display_image(boundary, self.processed_image_label)

    def apply_edge_detection(self):
        if self.original_image is not None:
            edges = feature.canny(self.original_image, sigma=1)
            self.display_image(edges, self.processed_image_label)

    def display_image(self, image, label):
        if image.dtype == np.bool_:
            image_display = image.astype(np.uint8) * 255  # Convert boolean array to uint8
        else:
            image_display = img_as_ubyte(image)  # Ensure image is uint8
        q_img = QImage(image_display.data, image_display.shape[1], image_display.shape[0], image_display.strides[0], QImage.Format_Grayscale8)
        pixmap = QPixmap.fromImage(q_img)
        label.setPixmap(pixmap.scaled(400, 300, Qt.KeepAspectRatio))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ImageProcessor()
    sys.exit(app.exec_())
