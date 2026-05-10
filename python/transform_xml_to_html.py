#!/usr/bin/env python3
"""
XML to HTML Transformation Pipeline
=====================================

This script automates the transformation of football_club.xml into 6 different
HTML visualizations using XSLT stylesheets.

Input:  data/football_club.xml
Output: output/*.html (6 files)

Stylesheets:
1. players_roster.xsl           -> Players directory with statistics
2. team_overview.xsl            -> Teams organized by age category
3. match_calendar.xsl           -> Competition schedule and results
4. coaching_staff.xsl           -> Coaching staff directory
5. training_schedule.xsl        -> Training sessions by team
6. club_dashboard.xsl           -> Executive summary dashboard

Author: Abdellahi
Date: 2026-05-10
"""

import os
import sys
from pathlib import Path
from lxml import etree
from datetime import datetime

# ============================================================================
# CONFIGURATION
# ============================================================================

# Define project paths relative to this script
SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent

# Input XML file
XML_INPUT = PROJECT_ROOT / "data" / "football_club.xml"

# XSLT stylesheets directory
XSLT_DIR = PROJECT_ROOT / "xslt"

# Output directory for HTML files
OUTPUT_DIR = PROJECT_ROOT / "output"

# Define transformations: (xslt_filename, html_output_filename)
TRANSFORMATIONS = [
    ("players_roster.xsl", "01_players_roster.html"),
    ("team_overview.xsl", "02_team_overview.html"),
    ("match_calendar.xsl", "03_match_calendar.html"),
    ("coaching_staff.xsl", "04_coaching_staff.html"),
    ("training_schedule.xsl", "05_training_schedule.html"),
    ("club_dashboard.xsl", "06_club_dashboard.html"),
]

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================


def print_header(title):
    """Print a formatted header"""
    print("\n" + "=" * 70)
    print(f"  {title}")
    print("=" * 70)


def print_info(message):
    """Print info message"""
    print(f"ℹ️  {message}")


def print_success(message):
    """Print success message"""
    print(f"✅ {message}")


def print_warning(message):
    """Print warning message"""
    print(f"⚠️  {message}")


def print_error(message):
    """Print error message"""
    print(f"❌ {message}")


def validate_file_exists(filepath, description):
    """Check if a file exists, exit if not"""
    if not filepath.exists():
        print_error(f"{description} not found: {filepath}")
        return False
    print_success(f"Found {description}: {filepath}")
    return True


def create_output_directory():
    """Create output directory if it doesn't exist"""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    print_success(f"Output directory ready: {OUTPUT_DIR}")


def load_xml_document(xml_path):
    """Load and validate XML document"""
    print_info(f"Loading XML document: {xml_path}")
    try:
        parser = etree.XMLParser(remove_blank_text=True)
        doc = etree.parse(str(xml_path), parser)
        print_success("XML document loaded successfully")
        return doc
    except etree.XMLSyntaxError as e:
        print_error(f"XML Syntax Error: {e}")
        return None
    except Exception as e:
        print_error(f"Error loading XML: {e}")
        return None


def load_xslt_stylesheet(xslt_path):
    """Load XSLT stylesheet"""
    try:
        xslt_doc = etree.parse(str(xslt_path))
        stylesheet = etree.XSLT(xslt_doc)
        return stylesheet
    except etree.XSLTParseError as e:
        print_error(f"XSLT Parse Error in {xslt_path}: {e}")
        return None
    except Exception as e:
        print_error(f"Error loading XSLT {xslt_path}: {e}")
        return None


def transform_xml_to_html(xml_doc, stylesheet, xslt_filename):
    """Apply XSLT transformation to XML document"""
    try:
        result = stylesheet(xml_doc)
        return result
    except Exception as e:
        print_error(f"Transformation error using {xslt_filename}: {e}")
        return None


def save_html_output(result, output_path):
    """Save transformation result to HTML file"""
    try:
        with open(output_path, 'wb') as f:
            f.write(etree.tostring(result, encoding='utf-8', method='html', pretty_print=True))
        return True
    except Exception as e:
        print_error(f"Error saving HTML to {output_path}: {e}")
        return False


def generate_transformation_report(results):
    """Generate summary report of all transformations"""
    print_header("TRANSFORMATION SUMMARY")
    
    successful = sum(1 for r in results if r['success'])
    total = len(results)
    
    for result in results:
        status = "✅ SUCCESS" if result['success'] else "❌ FAILED"
        print(f"\n{status}")
        print(f"  Stylesheet:  {result['xslt_filename']}")
        print(f"  Output:      {result['output_filename']}")
        if result['success']:
            print(f"  Size:        {result['file_size']} bytes")
        else:
            if result.get('error'):
                print(f"  Error:       {result['error']}")
    
    print("\n" + "-" * 70)
    print(f"Total: {successful}/{total} transformations completed successfully")
    print("-" * 70)
    
    return successful == total


# ============================================================================
# MAIN EXECUTION
# ============================================================================


def main():
    """Main execution function"""
    print_header("XML to HTML Transformation Pipeline")
    print_info(f"Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Step 1: Validate input files
    print_header("STEP 1: Validating Input Files")
    
    if not validate_file_exists(XML_INPUT, "XML Input"):
        return False
    
    if not XSLT_DIR.exists():
        print_error(f"XSLT directory not found: {XSLT_DIR}")
        return False
    print_success(f"Found XSLT directory: {XSLT_DIR}")
    
    # Check all required XSLT files
    all_xslt_exist = True
    for xslt_file, _ in TRANSFORMATIONS:
        xslt_path = XSLT_DIR / xslt_file
        if not xslt_path.exists():
            print_warning(f"XSLT file not found: {xslt_file}")
            all_xslt_exist = False
        else:
            print_success(f"Found XSLT: {xslt_file}")
    
    if not all_xslt_exist:
        print_error("Not all required XSLT files are present. Aborting.")
        return False
    
    # Step 2: Create output directory
    print_header("STEP 2: Preparing Output Directory")
    create_output_directory()
    
    # Step 3: Load XML document
    print_header("STEP 3: Loading XML Document")
    xml_doc = load_xml_document(XML_INPUT)
    if xml_doc is None:
        return False
    
    # Step 4: Execute transformations
    print_header("STEP 4: Executing XSLT Transformations")
    
    results = []
    
    for xslt_filename, html_filename in TRANSFORMATIONS:
        print_info(f"\nProcessing: {xslt_filename} → {html_filename}")
        
        xslt_path = XSLT_DIR / xslt_filename
        output_path = OUTPUT_DIR / html_filename
        
        # Load XSLT stylesheet
        stylesheet = load_xslt_stylesheet(xslt_path)
        if stylesheet is None:
            results.append({
                'xslt_filename': xslt_filename,
                'output_filename': html_filename,
                'success': False,
                'error': 'Failed to load XSLT'
            })
            continue
        
        # Apply transformation
        result = transform_xml_to_html(xml_doc, stylesheet, xslt_filename)
        if result is None:
            results.append({
                'xslt_filename': xslt_filename,
                'output_filename': html_filename,
                'success': False,
                'error': 'Transformation failed'
            })
            continue
        
        # Save output
        if save_html_output(result, output_path):
            file_size = os.path.getsize(output_path)
            print_success(f"Generated: {output_path}")
            results.append({
                'xslt_filename': xslt_filename,
                'output_filename': html_filename,
                'success': True,
                'file_size': file_size
            })
        else:
            results.append({
                'xslt_filename': xslt_filename,
                'output_filename': html_filename,
                'success': False,
                'error': 'Failed to save output'
            })
    
    # Step 5: Generate report
    all_successful = generate_transformation_report(results)
    
    if all_successful:
        print_header("✨ ALL TRANSFORMATIONS COMPLETED SUCCESSFULLY ✨")
        print(f"\n📁 Output files saved to: {OUTPUT_DIR}")
        print("\nGenerated HTML files:")
        for i, (_, html_filename) in enumerate(TRANSFORMATIONS, 1):
            print(f"   {i}. {html_filename}")
        return True
    else:
        print_header("⚠️  Some transformations failed")
        return False


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
