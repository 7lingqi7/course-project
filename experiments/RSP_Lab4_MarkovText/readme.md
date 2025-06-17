## 🔗 Exp 4: Markov Chain-Based Text Generation

This project implements a first-order Markov chain model to generate pseudo-natural English text based on a known corpus. It includes dictionary construction, weighted random word selection, and sequence generation.

---

### 🔧 Key Implementations

- **Word Dictionary Construction**
  - Preprocesses raw text by removing newline characters and quotes
  - Adds spacing around punctuation to tokenize them separately
  - Builds a nested dictionary: each word maps to its possible successors and their frequencies
  - Punctuation is given triple weight to improve text realism

- **Weighted Random Selection**
  - Calculates the total transition count from a word
  - Implements weighted random sampling to favor frequent successors

- **Text Generation**
  - Starts with the word `'I'`
  - Generates a sequence of 100 words using previous word's transition dictionary
  - Joins results into a coherent string with punctuation
  - Demonstrates syntactic plausibility due to pairwise word statistics

- **Flowchart and Analysis**
  - Flowchart visualizes the structure of the Markov model
  - Analysis notes that while the grammar is often correct, the narrative lacks coherence due to limited context modeling

---

### 📦 Libraries Used

- `random`
- `urllib.request`
- `string`

