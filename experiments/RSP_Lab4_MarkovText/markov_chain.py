from urllib.request import urlopen  # for fetching text from a URL
from random import randint

# Function to calculate the total sum of the frequencies of all words in a word list
def wordListSum(wordList):
    sum = 0
    for word, value in wordList.items():
        sum += value
    return sum

# Function to select a random word based on the frequency distribution of possible subsequent words
def retrieveRandomWord(wordList):
    # Generate a random index up to the sum of all frequencies in the word list
    randIndex = randint(1, wordListSum(wordList))
    for word, value in wordList.items():
        # Decrease randIndex by the frequency count until it is zero or negative
        randIndex -= value
        if randIndex <= 0:
            # Return the word that brings randIndex to zero or below, ensuring selection by weighted probability
            return word

# Function to build a dictionary that represents the Markov chain
def buildWordDict(text):
    # Remove newline characters and quotes from the text to clean it
    text = text.replace('\n', ' ').replace('"', '')

    # Specify punctuation marks to separate into distinct elements, enhancing their influence in the text
    punctuation = [',','.',';',':']
    for symbol in punctuation:
        # Surround each punctuation mark with spaces so they are separated like individual words
        text = text.replace(symbol, ' {} '.format(symbol))

    # Split the cleaned text into a list of words and punctuation marks
    words = text.split(' ')
    # Remove empty words that may have been created from double spaces
    words = [word for word in words if word != '']

    # Initialize a dictionary to hold word associations
    wordDict = {}
    # Iterate through each word in the list except the last one
    for i in range(1, len(words)):
        if words[i-1] not in wordDict:
            # Initialize a new dictionary for this word if it's not already in the dictionary
            wordDict[words[i-1]] = {}
        if words[i] not in wordDict[words[i-1]]:
            wordDict[words[i-1]][words[i]] = 0
        # Increment the count for this word's occurrence after the previous word
        increment = 3 if words[i] in punctuation else 1  # weight punctuation more heavily
        wordDict[words[i-1]][words[i]] += increment

    return wordDict

# Fetch text from a specified URL and read it into a string
text = str(urlopen('http://pythonscraping.com/files/inaugurationSpeech.txt').read(), 'utf-8')
# Build a Markov chain dictionary from the text
wordDict = buildWordDict(text)

# Generate a Markov chain text of 100 words starting with 'I'
length = 100
chain = ['You']
for i in range(0, length):
    # Add a new word by randomly selecting from the dictionary based on the last word in the chain
    newWord = retrieveRandomWord(wordDict[chain[-1]])
    chain.append(newWord)

# Join the words in the chain to form a coherent string and print it
print(' '.join(chain))


