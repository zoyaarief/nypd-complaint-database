
# NYPD Complaint Data Management System

## Overview
The NYPD Complaint Data Management System is a database-driven application that stores, manages, and retrieves NYPD complaint records. It supports efficient logging of complaints, tracking of incidents, managing evidence, linking evidence with cases, and storing details of officers and involved persons. The system simplifies case management and incident reporting through a structured relational database schema.

## Installation Instructions

### Database:

• MySQL Workbench (Version 8.0 or later): https://dev.mysql.com/downloads/workbench/
• MySQL Community Server: https://dev.mysql.com/downloads/mysql/


### Programming Language:

• Python 3.x: https://www.python.org/downloads/ Python Libraries:
• pymysql(Installusingpipinstallpymysql) 
• sys

## Project Setup

### 1. Create the Database:
• Open MySQL Workbench.
• Run: CREATE DATABASE IF NOT EXISTS nypd_database;
    
### 2. Import Schema:
• Use the import data tool to import the provided NYPD_dump.sql into
nypd_database. 

### 3. Setup and Run Application:
• Clone or download the project folder.
• Open the project in an IDE like VS Code or IntelliJ.
• Navigate to the project directory via terminal.
• Run python dashboard.py to start the application.
