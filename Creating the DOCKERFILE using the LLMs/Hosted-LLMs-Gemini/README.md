### Dockerfile Generator using Python and Ollama [Hosted (GEMINI)]


This project allows you to generate a Dockerfile for any programming language using a simple Python script. It leverages Ollama (a lightweight LLM framework) to assist with generating the Dockerfile.


##  Project Structure

hosted-llm-gemini/

├── generate_dockerfile_gemini.py # Python script for Dockerfile generation


##  Setup Instructions

### 1. Navigate to the Project Directory

```bash

cd hosted-llm-gemini

```

### 2. Create a Gemini API key

go to 
     https://aistudio.google.com/u/1/apikey?pli=1 

     create API key 

     copy the Key and paste it in the python code "xxxxxxxxxxxxxxxxxxxxxxxx"


### 2. Install Dependencies


Use pip to install the required packages:

```
pip install google.generativeai

```

### 3. Run the Script
Execute the script to generate a Dockerfile:

```
python generate_dockerfile_gemini.py

```

Enter the Programming language



### Expected Output

If your Programming language is : [eg: python]

'''

Generated Dockerfile:

FROM python:3.10

WORKDIR /app

COPY . .

'''
