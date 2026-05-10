# FC Méditerranée - Data Pipeline Project
## A25 School Project - DSTI

A comprehensive football club management system with XML data modeling, validation, and automated XSLT transformations to generate professional HTML reports.

---

## 📋 Project Overview

This project implements a full XML-based data pipeline for a fictional football club (FC Méditerranée) including:

- XML data model (14+ entities)
- XSD schema validation
- XSLT transformations (XML → HTML / XML / JSON)
- Python automation pipeline
- Professional reports (HTML + JSON outputs)

**Entities:** Players, Coaches, Teams, Training Sessions, Competitions, Matches, Facilities, Equipment, Memberships, Bookings

---

## 👥 Team & Responsibilities

### **Asma** (~25%)
**Python, Java & XML Processing**
- Python pipeline:
    *Load XML
    *Validate against XSD
    *Apply XSLT transformations
- Java pipeline (optional bonus, same functionality as Python)
- 2 XSLT → XML transformations (XML restructuring)

### **Abdelahi** (~25%)
**HTML Visualization (XSLT → HTML)**
- Development of 6 XSLT stylesheets
- 6 visualization scenarios (HTML reports)
- Clear natural-language comments for each XSLT
- Generation and storage of 6 HTML output files

### **Shayma** (~25%)
**JSON Export, Testing & Reporting**
- 2 XSLT → JSON transformations
- JSON Schema design for the 7th output
- Report contribution:
    *Scenario descriptions
    *Task distribution section
- Testing and validation of all outputs
- Review of XML / XSLT / Python consistency

### **Wassim** (~25%)
**Architecture & Packaging**
- XML Schema (XSD) design
- XML source dataset creation (14+ entities)
- Report contribution:
    *Data modeling choices
    *Tools justification
- Final integration and ZIP packaging of the project

---
```
python-xls-project/
├── data/
│   ├── football_club.xml        # Source XML data (14+ entities)
│   └── football_club.xsd        # XML Schema validation
│
├── xslt/
│   ├── players_roster.xsl
│   ├── team_overview.xsl
│   ├── match_calendar.xsl
│   ├── coaching_staff.xsl
│   ├── training_schedule.xsl
│   └── club_dashboard.xsl
│
├── python/
│   ├── requirements.txt
│   ├── transform_xml_to_html.py
│   ├── transform_xml_to_json.py
│   └── transform_xml_to_xml.py
│
├── output/
│   ├── 01_players_roster.html
│   ├── 02_team_overview.html
│   ├── 03_match_calendar.html
│   ├── 04_coaching_staff.html
│   ├── 05_training_schedule.html
│   ├── 06_club_dashboard.html
│   ├── sessions.json 
│   ├── active_members.json 
│   ├── rapport_joueurs.xml
│   ├── rapport_calendrier.xml 
│   └── README.md
│
├── .gitignore
└── README.md
```
---

## 🚀 Quick Start

### 1️⃣ **Prerequisites**
```bash
# Install Python 3.12+
python --version

# Install dependencies
pip install -r python/requirements.txt
```

### 2️⃣ **Generate HTML Reports**
```bash
cd python
python transform_xml_to_html.py
```
```
**Output:** files generated in `output/` folder
```
---
## 🔧 Technical Details
XML → Data modeling
XSD → Validation
XSLT 1.0 → Transformations
Python (lxml) → Automation pipeline
Java (optional) → Equivalent pipeline
HTML/CSS → Reporting layer
JSON → Structured export format
---
## 📝 Code Documentation

**All XSLT files include:**
- Detailed header comments (purpose, input, output, author)
- Inline comments for complex logic
- Clear variable names
- Organized template structure

**Python script includes:**
- Complete docstrings
- Function documentation
- Configuration section
- Utility functions with comments

**Example XSLT comment:**
```xml
<!--
  XSLT Stylesheet: Players Roster
  Description: Displays all players with statistics and positions
  Input: football_club.xml
  Output: HTML - Players directory
  Author: Abdellahi
  Date: 2026-05-10
-->
```
## References

- **XSLT Guide:** https://www.w3.org/TR/xslt
- **XPath Reference:** https://www.w3.org/TR/xpath/
- **lxml Documentation:** https://lxml.de/
- **HTML5 Standard:** https://html.spec.whatwg.org/
---



