<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT Stylesheet: Coaching Staff
  Description: Displays all coaches with their specialties, experience,
               assigned teams, and contact information
  
  Input: football_club.xml
  Output: HTML - Coaching staff directory with specialties
  
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
        <title>Coaching Staff - <xsl:value-of select="//fc:clubInfo/fc:name"/></title>
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
          }
          h1 {
            color: #1a1a1a;
            margin-bottom: 30px;
            text-align: center;
            font-size: 32px;
            font-weight: 600;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 15px;
          }
          .coaches-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
          }
          .coach-card {
            background: white;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.2s ease;
          }
          .coach-card:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
            border-color: #2c3e50;
          }
          .coach-header {
            background: #2c3e50;
            color: white;
            padding: 18px;
            text-align: center;
            border-bottom: 2px solid #1a252f;
          }
          .coach-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 4px;
          }
          .coach-role {
            font-size: 12px;
            opacity: 0.85;
            text-transform: uppercase;
          }
          .coach-body {
            padding: 18px;
          }
          .info-group {
            margin-bottom: 14px;
          }
          .info-label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 11px;
            text-transform: uppercase;
            margin-bottom: 6px;
          }
          .info-value {
            color: #333;
            font-size: 13px;
          }
          .specialty {
            display: inline-block;
            background: #f0f0f0;
            color: #2c3e50;
            padding: 4px 8px;
            border-radius: 2px;
            font-size: 11px;
            font-weight: 600;
            margin: 3px 3px 3px 0;
            border: 1px solid #d0d0d0;
          }
          .team-assigned {
            display: inline-block;
            background: #f9f4e6;
            color: #6b4423;
            padding: 4px 8px;
            border-radius: 2px;
            font-size: 11px;
            margin: 2px 0;
            border-left: 3px solid #d4a574;
          }
          .contact-info {
            font-size: 12px;
            color: #666;
          }
          .contact-info a {
            color: #2c3e50;
            text-decoration: none;
          }
          .contact-info a:hover {
            text-decoration: underline;
          }
          .experience-badge {
            display: inline-block;
            background: #f0f0f0;
            padding: 4px 8px;
            border-radius: 2px;
            font-size: 11px;
            color: #666;
            border: 1px solid #d0d0d0;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>🏅 Coaching Staff</h1>
          
          <div class="coaches-grid">
            <xsl:apply-templates select="//fc:coach">
              <xsl:sort select="fc:lastName"/>
              <xsl:sort select="fc:firstName"/>
            </xsl:apply-templates>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template for each coach -->
  <xsl:template match="fc:coach">
    <xsl:variable name="coachId" select="@id"/>
    <xsl:variable name="assignedTeams" select="//fc:team[fc:coachRef/@ref=$coachId]"/>
    
    <div class="coach-card">
      <div class="coach-header">
        <div class="coach-name">
          <xsl:value-of select="fc:firstName"/> <xsl:value-of select="fc:lastName"/>
        </div>
        <div class="coach-role">
          <xsl:value-of select="fc:role"/>
        </div>
      </div>

      <div class="coach-body">
        <!-- Specialties -->
        <div class="info-group">
          <div class="info-label">📚 Specialties</div>
          <xsl:choose>
            <xsl:when test="fc:specialty">
              <xsl:apply-templates select="fc:specialty"/>
            </xsl:when>
            <xsl:otherwise>
              <div class="info-value">Not specified</div>
            </xsl:otherwise>
          </xsl:choose>
        </div>

        <!-- Assigned Teams -->
        <div class="info-group">
          <div class="info-label">👥 Assigned Teams</div>
          <xsl:choose>
            <xsl:when test="$assignedTeams">
              <xsl:for-each select="$assignedTeams">
                <div class="team-assigned">
                  <xsl:value-of select="fc:name"/> (<xsl:value-of select="fc:ageCategory"/>)
                </div>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <div class="info-value">No teams assigned</div>
            </xsl:otherwise>
          </xsl:choose>
        </div>

        <!-- Experience -->
        <div class="info-group">
          <div class="info-label">📊 Experience</div>
          <div class="experience-badge">
            <xsl:value-of select="fc:yearsExperience"/> years
          </div>
        </div>

        <!-- Contact -->
        <div class="info-group">
          <div class="info-label">📞 Contact</div>
          <div class="contact-info">
            <div>✉️ <a href="mailto:{fc:contact/fc:email}"><xsl:value-of select="fc:contact/fc:email"/></a></div>
            <div>📱 <xsl:value-of select="fc:contact/fc:phone"/></div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Template for specialty items -->
  <xsl:template match="fc:specialty">
    <span class="specialty"><xsl:value-of select="."/></span>
  </xsl:template>

</xsl:stylesheet>
