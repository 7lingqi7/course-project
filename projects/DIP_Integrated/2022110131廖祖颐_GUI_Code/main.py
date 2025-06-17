import sys
from PySide6.QtWidgets import QApplication, QMainWindow, QPushButton, QVBoxLayout, QWidget, QLabel, QMessageBox
from PySide6.QtGui import QFont, QIcon
from PySide6.QtCore import Qt

# Import modules for each section
from image_processor import ImageProcessor as BasicOperationsModule
from image_processor_1 import ImageIntensityProcessor as ImageIntensityModule
from image_processor_2 import ImageProcessor2 as FrequencyDomainModule
from image_processor_3 import ImageProcessor3 as MorphologicalProcessingModule  # Add this line

class ImageProcessor(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.instruction_window = None
        self.basic_operations_window = None
        self.image_intensity_window = None
        self.frequency_domain_window = None
        self.morphological_processing_window = None  # Window for Morphological Processing

    def initUI(self):
        self.setWindowTitle("The Final DIP GUI Design")
        self.setWindowIcon(QIcon('app_icon.png'))
        self.setGeometry(300, 300, 600, 400)

        main_layout = QVBoxLayout()
        main_layout.setSpacing(10)

        title_label = QLabel("The Final DIP GUI Design")
        title_label.setFont(QFont("Arial", 24, QFont.Bold))
        title_label.setAlignment(Qt.AlignCenter)
        main_layout.addWidget(title_label)

        btn_instruction = QPushButton(" Instruction")
        btn_instruction.setIcon(QIcon('info_icon.png'))
        btn_instruction.setFont(QFont("Arial", 11))
        btn_instruction.clicked.connect(self.show_instructions)
        main_layout.addWidget(btn_instruction)

        sections = [
            "Basic Operations and Algebraic Operators for Digital Images",
            "Image Intensity Transformations and Spatial Filtering",
            "Image Processing in Frequency Domain and Image Restoration",
            "Morphological Processing"  # Add this section
        ]

        for section in sections:
            btn = QPushButton(section)
            btn.setFont(QFont("Arial", 11))
            if section == "Basic Operations and Algebraic Operators for Digital Images":
                btn.clicked.connect(self.open_basic_operations)
            elif section == "Image Intensity Transformations and Spatial Filtering":
                btn.clicked.connect(self.open_image_intensity)
            elif section == "Image Processing in Frequency Domain and Image Restoration":
                btn.clicked.connect(self.open_frequency_domain)
            elif section == "Morphological Processing":  # Setup the click event for the new section
                btn.clicked.connect(self.open_morphological_processing)
            main_layout.addWidget(btn)

        central_widget = QWidget(self)
        central_widget.setLayout(main_layout)
        self.setCentralWidget(central_widget)

    def open_basic_operations(self):
        if not self.basic_operations_window:
            self.basic_operations_window = BasicOperationsModule()
        self.basic_operations_window.show()

    def open_image_intensity(self):
        if not self.image_intensity_window:
            self.image_intensity_window = ImageIntensityModule()
        self.image_intensity_window.show()

    def open_frequency_domain(self):
        if not self.frequency_domain_window:
            self.frequency_domain_window = FrequencyDomainModule()
        self.frequency_domain_window.show()

    def open_morphological_processing(self):  # Define this new method
        if not self.morphological_processing_window:
            self.morphological_processing_window = MorphologicalProcessingModule()
        self.morphological_processing_window.show()

    def show_instructions(self):
        if not self.instruction_window:
            self.instruction_window = QWidget()
            self.instruction_window.setWindowTitle("Instructions")
            self.instruction_window.setGeometry(450, 450, 350, 200)
            instruction_layout = QVBoxLayout()

            info_label = QLabel("Designer: Zuyi Liao\nClass: Wenhua honor class\nStudent ID: 2022110131\nAdvisor: Professor Li Bin")
            info_label.setFont(QFont("Arial", 10))
            info_label.setAlignment(Qt.AlignLeft)
            info_label.setWordWrap(True)

            thanks_label = QLabel("Acknowledgement: Special thanks to Professor Li Bin for his guidance.")
            font = QFont("Arial", 10)
            font.setItalic(True)
            thanks_label.setFont(font)
            thanks_label.setStyleSheet("color: lightblue")
            thanks_label.setAlignment(Qt.AlignLeft)
            thanks_label.setWordWrap(True)

            instruction_layout.addWidget(info_label)
            instruction_layout.addWidget(thanks_label)

            self.instruction_window.setLayout(instruction_layout)

        self.instruction_window.show()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    ex = ImageProcessor()
    ex.show()
    sys.exit(app.exec())
