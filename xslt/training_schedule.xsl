<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT Stylesheet: Training Schedule
  Description: Displays upcoming training sessions organized by team,
               with date, time, location, and session details
  
  Input: football_club.xml
  Output: HTML - Training schedule with team filtering
  
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
        <title>Training Schedule - <xsl:value-of select="//fc:clubInfo/fc:name"/></title>
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
            max-width: 1100px;
            margin: 0 auto;
          }
          h1 {
            color: #1a1a1a;
            margin-bottom: 30px;
            text-align: center;
            font-size: 32px;
            font-weight: 600;
          }
          .team-schedule {
            background: white;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            overflow: hidden;
          }
          .team-schedule-header {
            background: #2c3e50;
            color: white;
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }
          .team-schedule-header h2 {
            font-size: 18px;
            margin: 0;
            font-weight: 600;
          }
          .sessions-container {
            padding: 20px;
          }
          .training-session {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px;
            margin-bottom: 10px;
            border-left: 4px solid #2c3e50;
            background: #f8f9fa;
            border-radius: 0;
            font-size: 12px;
          }
          .training-session:hover {
            background: #f0f0f5;
          }
          .session-datetime {
            display: flex;
            flex-direction: column;
            min-width: 130px;
            font-weight: 600;
            color: #2c3e50;
          }
          .session-date {
            font-size: 12px;
          }
          .session-time {
            font-size: 14px;
            color: #333;
          }
          .session-details {
            flex: 1;
            margin: 0 20px;
          }
          .session-title {
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 2px;
          }
          .session-coach {
            font-size: 11px;
            color: #666;
          }
          .session-type {
            display: inline-block;
            background: #f0f0f0;
            color: #2c3e50;
            padding: 2px 6px;
            border-radius: 2px;
            font-size: 10px;
            font-weight: 600;
            margin-right: 6px;
            margin-top: 2px;
            border: 1px solid #d0d0d0;
            text-transform: uppercase;
          }
          .session-location {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            min-width: 130px;
            text-align: right;
            font-size: 12px;
          }
          .location-name {
            font-size: 12px;
            font-weight: 600;
            color: #333;
          }
          .location-facility {
            font-size: 10px;
            color: #666;
          }
          .facility-badge {
            display: inline-block;
            background: #f9f4e6;
            color: #6b4423;
            padding: 2px 5px;
            border-radius: 2px;
            font-size: 10px;
            margin-top: 2px;
            border: 1px solid #e0d0c0;
          }
          .no-sessions {
            text-align: center;
            padding: 30px;
            color: #999;
            font-style: italic;
          }
          .session-duration {
            font-size: 10px;
            color: #999;
            margin-top: 2px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>🏃‍♂️ Training Schedule</h1>
          
          <xsl:apply-templates select="//fc:team">
            <xsl:sort select="fc:ageCategory"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template for each team's training schedule -->
  <xsl:template match="fc:team">
    <xsl:variable name="teamId" select="@id"/>
    
    <div class="team-schedule">
      <div class="team-schedule-header">
        <h2><xsl:value-of select="fc:name"/> - <xsl:value-of select="fc:ageCategory"/></h2>
        <div>👥 <strong><xsl:value-of select="count(//fc:player[@teamRef=$teamId])"/></strong> Players</div>
      </div>

      <div class="sessions-container">
        <xsl:choose>
          <xsl:when test="//fc:session[fc:teamRef/@refId=$teamId]">
            <xsl:apply-templates select="//fc:session[fc:teamRef/@refId=$teamId]">
              <xsl:sort select="fc:day"/>
              <xsl:sort select="fc:startTime"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <div class="no-sessions">
              No training sessions scheduled for this team
            </div>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <!-- Template for each training session -->
  <xsl:template match="fc:session">
    <xsl:variable name="facilityId" select="fc:facilityRef/@refId"/>
    <xsl:variable name="coachId" select="fc:coachRef/@refId"/>
    <xsl:variable name="facilityName" select="//fc:facility[@id=$facilityId]/fc:name"/>
    <xsl:variable name="coachName">
      <xsl:value-of select="//fc:coach[@id=$coachId]/fc:firstName"/> <xsl:value-of select="//fc:coach[@id=$coachId]/fc:lastName"/>
    </xsl:variable>
    
    <div class="training-session">
      <div class="session-datetime">
        <span class="session-date"><xsl:value-of select="fc:day"/></span>
        <span class="session-time"><xsl:value-of select="substring(fc:startTime, 1, 5)"/></span>
      </div>

      <div class="session-details">
        <div class="session-title">
          <xsl:value-of select="fc:description"/>
        </div>
        <div class="session-coach">
          Coach: <xsl:value-of select="$coachName"/>
        </div>
        <div>
          <span class="session-type">
            <xsl:value-of select="fc:type"/>
          </span>
          <span class="session-type">
            <xsl:value-of select="fc:intensity"/>
          </span>
        </div>
        <div class="session-duration">
          Duration: <xsl:value-of select="concat(substring(fc:startTime, 1, 5), ' - ', substring(fc:endTime, 1, 5))"/>
        </div>
      </div>

      <div class="session-location">
        <div class="location-name"><xsl:value-of select="$facilityName"/></div>
        <span class="facility-badge">
          <xsl:value-of select="//fc:facility[@id=$facilityId]/fc:type"/>
        </span>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
