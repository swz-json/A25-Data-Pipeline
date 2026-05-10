<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT Stylesheet: Players Roster
  Description: Displays all players with their personal information, 
               statistics, position, and jersey number in a tabular HTML format
  
  Input: football_club.xml
  Output: HTML - Players directory with filtering by position
  
  Author: Abdellahi
  Date: 2026-05-10
-->
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fc="http://www.dsti.football-club.com">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Root template -->
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Players Roster - <xsl:value-of select="//fc:clubInfo/fc:name"/></title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }
          body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #f8f9fa;
            padding: 20px;
            min-height: 100vh;
            color: #333;
          }
          .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            padding: 30px;
          }
          h1 {
            color: #1a1a1a;
            margin-bottom: 10px;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 12px;
            font-size: 28px;
            font-weight: 600;
          }
          .club-info {
            color: #666;
            margin-bottom: 20px;
            font-size: 13px;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
          }
          th {
            background: #2c3e50;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
          }
          tr:hover {
            background: #f5f5f5;
          }
          td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
            font-size: 13px;
          }
          .captain {
            background: #f9f4e6;
          }
          .position-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 2px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
          }
          .goalkeeper { background: #fce4e4; color: #b71c1c; }
          .defender { background: #e8f5e9; color: #2e7d32; }
          .midfielder { background: #e3f2fd; color: #1565c0; }
          .forward { background: #fff3e0; color: #e65100; }
          .stats {
            font-size: 12px;
            color: #666;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>⚽ Players Roster</h1>
          <div class="club-info">
            <p><strong>Club:</strong> <xsl:value-of select="//fc:clubInfo/fc:name"/></p>
            <p><strong>Location:</strong> <xsl:value-of select="//fc:clubInfo/fc:address/fc:city"/></p>
            <p><strong>Founded:</strong> <xsl:value-of select="//fc:clubInfo/fc:founded"/></p>
          </div>

          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Name</th>
                <th>Position</th>
                <th>Team</th>
                <th>Age</th>
                <th>Height/Weight</th>
                <th>Preferred Foot</th>
                <th>Goals (2025)</th>
                <th>Assists (2025)</th>
                <th>Contact</th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="//fc:player">
                <xsl:sort select="fc:jerseyNumber" data-type="number"/>
              </xsl:apply-templates>
            </tbody>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template for each player -->
  <xsl:template match="fc:player">
    <xsl:variable name="captain" select="@isCaptain"/>
    <xsl:variable name="posClass">
      <xsl:choose>
        <xsl:when test="fc:position = 'Goalkeeper'">goalkeeper</xsl:when>
        <xsl:when test="fc:position = 'Defender'">defender</xsl:when>
        <xsl:when test="fc:position = 'Midfielder'">midfielder</xsl:when>
        <xsl:when test="fc:position = 'Forward'">forward</xsl:when>
        <xsl:otherwise>midfielder</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <tr>
      <xsl:if test="$captain = 'true'">
        <xsl:attribute name="class">captain</xsl:attribute>
      </xsl:if>
      <td>
        <strong><xsl:value-of select="fc:jerseyNumber"/></strong>
        <xsl:if test="$captain = 'true'"> 👑</xsl:if>
      </td>
      <td>
        <xsl:value-of select="fc:firstName"/> <xsl:value-of select="fc:lastName"/>
      </td>
      <td>
        <span class="position-badge {$posClass}">
          <xsl:value-of select="fc:position"/>
        </span>
      </td>
      <td>
        <xsl:value-of select="//fc:team[@id=current()/@teamRef]/fc:name"/>
      </td>
      <td>
        <xsl:call-template name="calculate-age">
          <xsl:with-param name="dob" select="fc:dateOfBirth"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:value-of select="fc:height"/>cm / <xsl:value-of select="fc:weight"/>kg
      </td>
      <td>
        <xsl:value-of select="fc:preferredFoot"/>
      </td>
      <td class="stats">
        <xsl:value-of select="fc:statistics/fc:goals"/>
      </td>
      <td class="stats">
        <xsl:value-of select="fc:statistics/fc:assists"/>
      </td>
      <td>
        <small><xsl:value-of select="fc:contact/fc:email"/></small>
      </td>
    </tr>
  </xsl:template>

  <!-- Template to calculate age from date of birth -->
  <xsl:template name="calculate-age">
    <xsl:param name="dob"/>
    <!-- Simple age calculation: using 2026 as current year -->
    <xsl:value-of select="2026 - substring($dob, 1, 4)"/>
  </xsl:template>

</xsl:stylesheet>
