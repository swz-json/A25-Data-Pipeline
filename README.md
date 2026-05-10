# FC Méditerranée - Data Pipeline Project
## A25 School Project - DSTI

A comprehensive football club management system with XML data modeling, validation, and automated XSLT transformations to generate professional HTML reports.

---

## 📋 Project Overview

This project implements a complete **data pipeline** for a fictional football club (FC Méditerranée) with:
- ✅ XML data source with 14+ entity types
- ✅ XSD schema validation
- ✅ 6 XSLT stylesheets for HTML visualization
- ✅ Automated Python transformation pipeline
- ✅ Professional, responsive HTML reports

**Entities:** Players, Coaches, Teams, Training Sessions, Competitions, Matches, Facilities, Equipment, Memberships, Bookings

---

## 👥 Team & Responsibilities

### **Abdellahi** (~25%)
**XSLT & HTML Visualization**
- ✅ Created 6 XSLT → HTML stylesheets
- ✅ Professional responsive design
- ✅ Complete code documentation
- 📁 Output: `xslt/` (6 files) + `output/` (6 HTML files)

### **Wassim** (~25%)
**Architecture & Modeling**
- 📋 XML Schema (XSD) design
- 📝 XML source data file
- 📁 Files: `data/football_club.xsd`, `data/football_club.xml`

### **Shayma** (~25%)
**Technical Implementation & QA**
- 🐍 Python/Java pipeline (optional bonus)
- 🧪 Testing & validation
- 📁 Files: `python/` (transformation scripts)

### **Team** (~25%)
**Documentation & Additional XSLT**
- 2 XSLT → JSON transformations (not in this folder)
- PDF report (6 pages max)
- JSON Schema for output

---

## 📁 Project Structure

```
python-xls-project/
├── data/
│   ├── football_club.xml          # Source XML data (14+ entities)
│   └── football_club.xsd          # XML Schema validation
│
├── xslt/
│   ├── players_roster.xsl         # Players directory
│   ├── team_overview.xsl          # Teams by position
│   ├── match_calendar.xsl         # Match schedule
│   ├── coaching_staff.xsl         # Coach directory
│   ├── training_schedule.xsl      # Training sessions
│   └── club_dashboard.xsl         # Executive summary
│
├── python/
│   ├── transform_xml_to_html.py   # Main transformation script
│   └── requirements.txt            # Python dependencies
│
├── output/
│   ├── 01_players_roster.html     # Generated report
│   ├── 02_team_overview.html      # Generated report
│   ├── 03_match_calendar.html     # Generated report
│   ├── 04_coaching_staff.html     # Generated report
│   ├── 05_training_schedule.html  # Generated report
│   ├── 06_club_dashboard.html     # Generated report
│   └── README.md                  # File descriptions
│
├── .gitignore                      # Git ignore rules
└── README.md                       # This file
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

**Output:** 6 HTML files generated in `output/` folder

### 3️⃣ **View Reports**
Open any HTML file in a web browser:
- `output/01_players_roster.html`
- `output/02_team_overview.html`
- `output/03_match_calendar.html`
- `output/04_coaching_staff.html`
- `output/05_training_schedule.html`
- `output/06_club_dashboard.html`

---

## 📊 HTML Reports (6 Visualizations)

| # | File | Purpose | Use Case |
|---|------|---------|----------|
| 1 | players_roster.html | Complete player directory | HR, Management, Scouts |
| 2 | team_overview.html | Teams organized by position | Coaching, Academy Planning |
| 3 | match_calendar.html | Competition schedule & results | Fans, Media, Scheduling |
| 4 | coaching_staff.html | Coach profiles & assignments | Admin, Communication |
| 5 | training_schedule.html | Weekly training sessions | Players, Parents, Coaches |
| 6 | club_dashboard.html | Executive summary metrics | Management, Sponsors |

**→ See [output/README.md](output/README.md) for detailed descriptions**

---

## 🔧 Technical Details

### XML Data Model
- **14+ entity types:** Players, Coaches, Teams, Competitions, Matches, etc.
- **Validation:** Against XSD schema
- **Features:** Referential integrity, attributes, nested structures

### XSLT Stylesheets
- **Language:** XSLT 1.0
- **Features:** 
  - XPath queries & XPath functions
  - Conditional logic (xsl:choose)
  - Sorting & grouping
  - Variables & templates
  - CSS styling embedded in HTML

### Python Pipeline
- **Library:** lxml (XSLT processor)
- **Features:**
  - Automated transformations
  - Error handling & validation
  - Progress reporting
  - Summary statistics

---

## 📝 Code Documentation

**All XSLT files include:**
- ✅ Detailed header comments (purpose, input, output, author)
- ✅ Inline comments for complex logic
- ✅ Clear variable names
- ✅ Organized template structure

**Python script includes:**
- ✅ Complete docstrings
- ✅ Function documentation
- ✅ Configuration section
- ✅ Utility functions with comments

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

---

## 🔄 Workflow: XML → HTML

```
1. Source Data
   ↓
   data/football_club.xml
   ↓
2. Validation
   ↓
   Validate against football_club.xsd
   ↓
3. Transformation (Python Script)
   ↓
   python/transform_xml_to_html.py
   ↓
4. XSLT Processing (6 stylesheets)
   ↓
   xslt/*.xsl + XML → HTML
   ↓
5. Output Generation
   ↓
   output/*.html (6 files)
```

---

## 🎨 Design Principles

### Styling
- **Professional color scheme:** Dark blue (#2c3e50) headers
- **Clean UI:** White backgrounds, subtle shadows
- **Responsive:** Adapts to all screen sizes
- **Readable:** System fonts, proper contrast

### Information Architecture
- **Color-coded:** Positions, intensity, status badges
- **Sortable:** By jersey number, position, category
- **Organized:** Grouped by team, competition, type
- **Accessible:** Semantic HTML, proper headings

---

## 📦 Dependencies

**Python:**
- `lxml>=5.0.0` - XML/XSLT processing

**System:**
- Python 3.12+
- Any modern web browser (Chrome, Firefox, Safari, Edge)

---

## 📝 Generated Files

After running `python transform_xml_to_html.py`:

```
output/
├── 01_players_roster.html       (~7 KB)
├── 02_team_overview.html        (~8 KB)
├── 03_match_calendar.html       (~5 KB)
├── 04_coaching_staff.html       (~8 KB)
├── 05_training_schedule.html    (~10 KB)
├── 06_club_dashboard.html       (~13 KB)
└── README.md                    (descriptions)
```

**Total:** ~51 KB of generated HTML

---

## 🔍 Validation

### XML Validation
```bash
# Validate XML against XSD
xmllint --schema data/football_club.xsd data/football_club.xml
```

### XSLT Validation
- All stylesheets tested and working
- No syntax errors
- All transformations successful

### Python Validation
- Error handling for missing files
- Detailed error messages
- Success/failure reporting

---

## 🛠️ Customization

### To modify a report:
1. Edit the corresponding XSLT file in `xslt/`
2. Run `python transform_xml_to_html.py`
3. View updated HTML in `output/`

### To update data:
1. Modify `data/football_club.xml`
2. Ensure it validates against XSD
3. Run transformation script

### To change styling:
- Edit CSS in the `<style>` section of any XSLT file
- Colors, fonts, spacing can be customized
- Regenerate HTML

---

## 📚 References

- **XSLT Guide:** https://www.w3.org/TR/xslt
- **XPath Reference:** https://www.w3.org/TR/xpath/
- **lxml Documentation:** https://lxml.de/
- **HTML5 Standard:** https://html.spec.whatwg.org/

---

## 📄 License & Credits

**Project:** A25 - Data Pipeline 1  
**Institution:** DSTI  
**Created:** May 2026  
**Team:** Abdellahi, Wassim, Shayma, + Classmates

---

## 📞 Support

**Issues or questions?**
- Check `output/README.md` for file descriptions
- Review XSLT comments in `xslt/` folder
- Check Python script output for errors
- Validate XML against XSD schema

**Running transform script manually:**
```bash
cd python
python transform_xml_to_html.py
```

---

## ✅ Checklist

- [x] XML data model with 14+ entities
- [x] XSD schema validation
- [x] 6 XSLT stylesheets
- [x] Professional HTML design
- [x] Python automation script
- [x] Error handling & logging
- [x] Complete documentation
- [x] Code comments
- [x] Git repository setup
- [x] .gitignore configuration

**Status:** ✅ Ready for submission
