# Real Estate Sales Data Engineering ETL Project
----------------------------------------------

This project aims to extract, transform, and load (ETL) real estate sales data into a data warehouse (re\_sales\_dw) in the stat schema.

### Overview

The data warehouse consists of one fact table and five dimension tables:

*   **Fact Table**: sales
    
    *   Measures:
        
        *   sale\_amount
            
        *   assessed\_value
            
        *   sale\_ratio
            
*   **Dimension Tables**:
    
    1.  dim\_year – Contains year information.
        
    2.  dim\_property\_type – Contains property type data.
        
    3.  dim\_nonuse\_code – Contains non-use codes.
        
    4.  dim\_location – Contains location details.
        
    5.  dim\_sale\_date – Contains sale date information.
        

The ETL process is implemented using Python with libraries like pandas, sqlalchemy, and psycopg2.

### Project Structure

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   Real_Estate_Sales_ETL_Project  ├── data  │   └── sales_data.csv  # Sample CSV file with sales data  ├── queries  │   └── create_dw_schema.sql  # SQL to create the data warehouse schema  ├── notebooks  │   └── etl_process.ipynb  # Jupyter notebook for ETL process  ├── README.md  # Project overview and instructions   `

### Requirements

*   Python 3.7+
    
*   PostgreSQL (or your preferred relational DB)
    
*   Python libraries:
    
    *   pandas
        
    *   sqlalchemy
        
    *   psycopg2
        
    *   numpy
        

Install required libraries:

Bash

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   pip install pandas sqlalchemy psycopg2 numpy   `

### Setup Instructions

1.  **Create the Data Warehouse Schema**
    

Run the SQL query in queries/create\_dw\_schema.sql to create the data warehouse schema (re\_sales\_dw in the stat schema). The schema includes one fact table (sales) and five dimension tables (dim\_year, dim\_property\_type, dim\_nonuse\_code, dim\_location, dim\_sale\_date).

1.  **Setup Database Connection**
    

In the etl\_process.ipynb notebook, set up the database connection using sqlalchemy. Modify the connection string to match your PostgreSQL credentials.

1.  **Running the ETL Process**
    

Open the Jupyter notebook notebooks/etl\_process.ipynb. Follow the steps in the notebook to perform the ETL process:

*   Extract: Load sales data from data/sales\_data.csv.
    
*   Transform: Clean and reshape the data as needed.
    
*   Load: Insert data into the sales fact table and dimension tables.
    

1.  **Verify Data in Database**
    

After running the ETL process, verify the data in the sales and dimension tables by querying the database:

SQL

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   SELECT * FROM stat.sales;  SELECT * FROM stat.dim_year;  SELECT * FROM stat.dim_property_type;  -- And so on for other dimension tables   `

### Contributing

If you'd like to contribute to the project:

*   Fork the repository.
    
*   Create a new branch for your feature/fix.
    
*   Commit and push your changes.
    
*   Open a pull request.
    

### License

This project is licensed under the MIT License.

### Troubleshooting

*   **Database Connection Issues:** Ensure PostgreSQL is running and the connection string is correct.
    
*   **Missing Packages:** Install missing packages with pip install -r requirements.txt.
    
*   **No Data Loaded:** Verify that the transformation logic in the notebook is correct and that the database schema is set up properly.