# FC Méditerranée - HTML Visualizations

This folder contains 6 HTML reports generated from the football club's XML data. Each file provides a different visualization of the club's operations.

---

## 📋 File Descriptions

### 1️⃣ **01_players_roster.html**
**Complete Players Directory**

Displays all players in the club with their personal and performance data in a professional table format.

**Includes:**
- Jersey number & captain badge
- Player name and position (color-coded)
- Team assignment
- Age, height, weight
- Preferred foot
- 2025 season statistics (goals, assists)
- Contact email

**Use Case:** HR, management, or team planning - see complete roster at a glance.

---

### 2️⃣ **02_team_overview.html**
**Team Organization by Position**

Organizes all teams by age category with squad composition grouped by position (GK, Defender, Midfielder, Forward).

**Includes:**
- Teams organized by category (Senior, U17, U15, etc.)
- Player count per team
- Squad breakdown by position
- Players listed with jersey numbers
- Captain indicators

**Use Case:** Coaching staff, academy planning - understand team structure and squad balance.

---

### 3️⃣ **03_match_calendar.html**
**Competition Schedule & Results**

Shows all matches organized by competition with dates, results, and match status.

**Includes:**
- Competitions grouped by season
- Match date, time, and venue
- Home vs Away teams
- Final scores & results
- Win/Loss/Draw badges
- Pending matches indicator

**Use Case:** Fans, media, scheduling - track match calendar and historical results.

---

### 4️⃣ **04_coaching_staff.html**
**Coaching Directory**

Professional profiles of all coaches with their specialties and assignments.

**Includes:**
- Coach name and role
- Specialties/expertise areas
- Assigned teams (by age category)
- Years of experience
- Contact information (email, phone)
- Individual coach cards with details

**Use Case:** Administration, communication - contact coaches and understand their expertise.

---

### 5️⃣ **05_training_schedule.html**
**Weekly Training Sessions**

Detailed schedule of all training sessions organized by team.

**Includes:**
- Teams with player count
- Training day and time
- Session description & objectives
- Session type (Technical, Tactical, Physical, etc.)
- Intensity level (Low, Medium, High)
- Duration (start-end times)
- Assigned coach & facility

**Use Case:** Players, parents, coaches - know when and where to train.

---

### 6️⃣ **06_club_dashboard.html**
**Executive Summary Dashboard**

High-level overview of club operations with key statistics and metrics.

**Includes:**
- Quick statistics (total players, teams, coaches, facilities)
- Top scorers in 2025
- Top assist makers in 2025
- Teams overview
- Latest match results
- Training facilities list
- Club contact information

**Use Case:** Management, sponsors, media - executive-level club overview.

---

## 🔄 How These Files Are Generated

All HTML files are automatically generated from **`football_club.xml`** using XSLT stylesheets:

```
football_club.xml
     ↓
  (6 XSLT transformations)
     ↓
├─ 01_players_roster.html
├─ 02_team_overview.html
├─ 03_match_calendar.html
├─ 04_coaching_staff.html
├─ 05_training_schedule.html
└─ 06_club_dashboard.html
```

**To regenerate** all files after updating XML data:
```bash
cd python
python transform_xml_to_html.py
```

---

## 📂 Related Files

- **Data Source:** `../data/football_club.xml`
- **XSD Schema:** `../data/football_club.xsd`
- **XSLT Stylesheets:** `../xslt/` (6 files)
- **Python Script:** `../python/transform_xml_to_html.py`

---

## 🎨 Styling

All HTML files use:
- **Professional color scheme:** Dark blue (#2c3e50) headers with clean white backgrounds
- **Responsive design:** Adapts to desktop and mobile screens
- **Consistent typography:** System fonts for better readability
- **Color-coded information:** Positions, badges, intensity levels for quick scanning
- **Accessibility:** Proper contrast ratios and semantic HTML

---

## 📝 Notes

- Files are **read-only** (generated from source XML)
- Always regenerate after XML updates
- Use `transform_xml_to_html.py` to create updated versions
- Each file is self-contained (no external dependencies)

**Generated:** May 10, 2026  
**Author:** Abdellahi  
**Project:** A25 - Data Pipeline 1 (DSTI)
