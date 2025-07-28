# Destroyer_1b


# PDF Content Analyzer & Summarizer

An intelligent document processing tool that extracts, ranks, and summarizes PDF content based on user-defined personas and tasks using advanced NLP techniques.

## 🚀 Features

- **Multi-PDF Processing**: Batch process multiple PDF documents simultaneously
- **Semantic Ranking**: Uses sentence transformers to rank content by relevance to your specific needs
- **Intelligent Summarization**: Employs BART-large-CNN model for high-quality text summarization
- **Persona-Driven Analysis**: Tailors content extraction based on user persona and job requirements
- **Structured Output**: Generates comprehensive JSON reports with metadata and analysis

## 📋 Prerequisites

- Python 3.7+
- Google Colab environment (recommended) or local Python environment
- PDF documents to analyze

## 🛠 Installation

### Required Libraries

```bash
pip install pymupdf sentence-transformers transformers torch
```

### Library Breakdown

- **pymupdf (fitz)**: PDF reading and text extraction
- **sentence-transformers**: Semantic similarity computation using pre-trained models
- **transformers**: Hugging Face transformers for text summarization
- **torch**: PyTorch backend for neural networks

## 📁 Directory Structure

```
project/
├── Adobe_1b.ipynb          # Main notebook file
├── input/                  # Input directory for PDF files
│   ├── sample.pdf         # Your PDF documents
│   └── [other_pdfs].pdf
└── output/                 # Output directory
    └── challenge1b_output.json  # Generated analysis results
```

## 🔧 Core Components

### 1. PDF Content Extraction

```python
def extract_pdf_content(pdf_path):
    """
    Extracts text content from PDF documents page by page.
    
    Returns:
        List of tuples: (page_number, page_text)
    """
```

**Features:**
- Page-by-page text extraction
- Handles multi-page documents
- Preserves page structure and numbering

### 2. Semantic Content Ranking

```python
def rank_sections(text_by_page, persona, job):
    """
    Ranks document sections based on semantic similarity to user query.
    
    Uses: all-MiniLM-L6-v2 sentence transformer model
    Method: Cosine similarity between query and text sections
    """
```

**Process:**
1. Creates semantic query: `"{persona}. Task: {job}"`
2. Splits pages into sections using double newlines
3. Computes embeddings for query and each section
4. Ranks sections by cosine similarity scores

### 3. Text Preprocessing & Cleaning

```python
def clean_text(text):
    """Removes extra whitespace and non-ASCII characters"""

def remove_persona_and_job(text, persona, job):
    """Removes persona and job keywords to prevent bias in summaries"""

def chunk_text(text, max_words=400):
    """Splits text into manageable chunks for summarization"""
```

### 4. AI-Powered Summarization

```python
def analyze_subsection(section_text, persona, job):
    """
    Generates concise summaries using facebook/bart-large-cnn model.
    
    Features:
    - Chunk-based processing for long texts
    - Error handling for failed summarizations
    - Configurable summary length (40-150 words)
    """
```

### 5. Document Processing Pipeline

```python
def process_documents(pdf_paths, persona, job):
    """
    Main processing function that orchestrates the entire workflow.
    
    Returns:
        Structured JSON with metadata and analysis results
    """
```

## 🎯 Usage

### Basic Usage

1. **Set up your environment:**
   ```python
   import os
   os.environ["CUDA_LAUNCH_BLOCKING"] = "1"  # For GPU stability
   ```

2. **Define your parameters:**
   ```python
   persona = "Government policy maker"
   job = "Improve coastal resilience strategies"
   ```

3. **Prepare your PDFs:**
   - Place PDF files in `${PWD}/input/` directory
   - Ensure files have `.pdf` extension

4. **Run the analysis:**
   ```python
   pdf_dir = "/input"
   pdf_paths = [os.path.join(pdf_dir, f) for f in os.listdir(pdf_dir) if f.endswith(".pdf")]
   output_json = process_documents(pdf_paths, persona, job)
   ```

### Interactive Mode

The notebook includes interactive input prompts:

```python
persona = input("Enter the persona: ")
job = input("Enter the job: ")
```

**Example Inputs:**
- **Persona**: "Healthcare administrator", "Environmental scientist", "Financial analyst"
- **Job**: "Reduce hospital readmissions", "Assess climate impact", "Optimize investment portfolio"

## 📊 Output Structure

The tool generates a comprehensive JSON file with the following structure:

```json
{
  "metadata": {
    "input_documents": ["sample.pdf", "document2.pdf"],
    "persona": "Government policy maker",
    "job_to_be_done": "Improve coastal resilience",
    "processing_timestamp": "2024-01-15T10:30:00.123456"
  },
  "extracted_sections": [
    {
      "document": "sample.pdf",
      "page_number": 5,
      "section_title": "Coastal Infrastructure Assessment...",
      "importance_rank": 1
    }
  ],
  "sub_section_analysis": [
    {
      "document": "sample.pdf",
      "page_number": 5,
      "refined_text": "AI-generated summary of the most relevant content..."
    }
  ]
}
```

### Output Components

- **metadata**: Processing details and input parameters
- **extracted_sections**: Ranked list of relevant document sections
- **sub_section_analysis**: Summarized and refined content for each section

## 🔍 Technical Details

### AI Models Used

1. **Sentence Transformer**: `all-MiniLM-L6-v2`
   - Purpose: Semantic similarity computation
   - Size: ~90MB
   - Performance: Fast inference, good accuracy

2. **Summarization Model**: `facebook/bart-large-cnn`
   - Purpose: Text summarization
   - Size: ~1.6GB
   - Performance: High-quality summaries, slower inference

### Processing Logic

1. **Content Extraction**: Raw text extraction from PDFs
2. **Section Splitting**: Documents divided by double newlines
3. **Relevance Scoring**: Semantic similarity to persona+job query
4. **Content Filtering**: Sections must be >30 characters
5. **Text Cleaning**: Remove non-ASCII, normalize whitespace
6. **Bias Removal**: Strip persona/job keywords from summaries
7. **Chunking**: Split long texts for summarization limits
8. **Summarization**: Generate 40-150 word summaries per chunk

## ⚙️ Configuration Options

### Customizable Parameters

- **Maximum chunk size**: Default 400 words
- **Summary length**: 40-150 words (configurable)
- **Minimum section length**: 30 characters
- **Number of top sections**: Currently processes all sections

### Performance Tuning

- **CPU Mode**: Set `device=-1` for CPU-only processing
- **GPU Mode**: Remove device parameter for GPU acceleration
- **Memory Management**: Adjust chunk sizes for available RAM

## 🚨 Error Handling

The tool includes robust error handling:

- **PDF Reading Errors**: Graceful handling of corrupted PDFs
- **Summarization Failures**: Fallback error messages
- **Empty Sections**: Automatic filtering of short content
- **Memory Issues**: Chunked processing for large documents

## 📝 Example Use Cases

### 1. Policy Research
- **Persona**: "Government policy analyst"
- **Job**: "Draft climate change legislation"
- **Input**: Environmental reports, policy documents
- **Output**: Relevant policy recommendations and data

### 2. Academic Research
- **Persona**: "Graduate student in biology"
- **Job**: "Literature review on gene therapy"
- **Input**: Scientific papers and reviews
- **Output**: Key findings and methodologies

### 3. Business Analysis
- **Persona**: "Management consultant"
- **Job**: "Market expansion strategy"
- **Input**: Market reports, competitor analysis
- **Output**: Strategic insights and recommendations

## 🔧 Troubleshooting

### Common Issues

1. **Out of Memory Errors**
   - Reduce chunk size in `chunk_text()`
   - Process fewer PDFs simultaneously
   - Use CPU mode instead of GPU

2. **Poor Summarization Quality**
   - Ensure input text is clean and well-formatted
   - Check that sections are substantive (>30 chars)
   - Verify persona and job descriptions are specific

3. **Low Relevance Scores**
   - Make persona and job descriptions more specific
   - Check PDF text extraction quality
   - Ensure documents contain relevant content

### Performance Optimization

- **Batch Size**: Process PDFs in smaller batches for large datasets
- **Model Caching**: Models are loaded once and reused
- **Text Preprocessing**: Efficient regex-based cleaning


## 🤝 Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch
3. Implement your changes
4. Add appropriate tests
5. Submit a pull request

## 📞 Support

For issues and questions:

1. Check the troubleshooting section
2. Review the example use cases
3. Ensure all dependencies are properly installed
4. Verify your input format matches the expected structure

---

