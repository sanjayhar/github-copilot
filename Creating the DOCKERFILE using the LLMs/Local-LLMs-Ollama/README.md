#  Dockerfile Generator using Python and Ollama

This project allows you to generate a Dockerfile for any programming language using a simple Python script. It leverages [Ollama](https://ollama.com/) (a lightweight LLM framework) to assist with generating the Dockerfile.

---

##  Project Structure

local-llm-ollama/

├── generate_dockerfile.py # Python script for Dockerfile generation

├── requirements.txt # Dependency file (contains ollama)


---

##  Setup Instructions

### 1. Navigate to the Project Directory

```bash

cd local-llm-ollama

```

### 2. Install Dependencies


Use pip to install the required packages:

```
pip install -r requirements.txt

```

### 3. Run the Script
Execute the script to generate a Dockerfile:

```
python generate_dockerfile.py

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
