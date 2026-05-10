<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT Stylesheet: Team Overview
  Description: Displays teams organized by age category with player composition
               by position (Goalkeeper, Defender, Midfielder, Forward)
  
  Input: football_club.xml
  Output: HTML - Team organization with squad breakdown
  
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
        <title>Team Overview - <xsl:value-of select="//fc:clubInfo/fc:name"/></title>
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
            max-width: 1400px;
            margin: 0 auto;
          }
          h1 {
            color: #1a1a1a;
            margin-bottom: 30px;
            text-align: center;
            font-size: 32px;
            font-weight: 600;
          }
          .team-section {
            background: white;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            overflow: hidden;
          }
          .team-header {
            background: #2c3e50;
            color: white;
            padding: 18px 20px;
          }
          .team-header h2 {
            font-size: 20px;
            font-weight: 600;
            margin: 0 0 8px 0;
          }
          .team-stats {
            display: flex;
            gap: 30px;
            font-size: 13px;
            color: #ecf0f1;
          }
          .team-body {
            padding: 20px;
          }
          .position-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 18px;
          }
          .position-box {
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            padding: 14px;
            background: #f8f9fa;
          }
          .position-title {
            font-weight: 600;
            font-size: 14px;
            padding-bottom: 10px;
            border-bottom: 2px solid;
            margin-bottom: 10px;
          }
          .goalkeeper .position-title { border-color: #d9534f; color: #c9302c; }
          .defender .position-title { border-color: #5cb85c; color: #449d44; }
          .midfielder .position-title { border-color: #0275d8; color: #004085; }
          .forward .position-title { border-color: #f0ad4e; color: #d58512; }
          
          .player-in-position {
            padding: 8px;
            margin-bottom: 6px;
            background: white;
            border-left: 3px solid;
            border-radius: 0;
            font-size: 13px;
          }
          .goalkeeper .player-in-position { border-color: #d9534f; }
          .defender .player-in-position { border-color: #5cb85c; }
          .midfielder .player-in-position { border-color: #0275d8; }
          .forward .player-in-position { border-color: #f0ad4e; }
          
          .player-number {
            font-weight: bold;
            color: #667eea;
            margin-right: 8px;
          }
          .player-captain { color: #ff9900; font-weight: bold; }
          .position-count {
            float: right;
            background: #e8e8e8;
            padding: 2px 6px;
            border-radius: 12px;
            font-size: 12px;
          }
          .no-players {
            color: #999;
            font-style: italic;
            padding: 10px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>🏆 Team Organization</h1>
          
          <xsl:apply-templates select="//fc:team">
            <xsl:sort select="fc:ageCategory"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template for each team -->
  <xsl:template match="fc:team">
    <xsl:variable name="teamId" select="@id"/>
    <xsl:variable name="playerCount" select="count(//fc:player[@teamRef=$teamId])"/>
    
    <div class="team-section">
      <div class="team-header">
        <h2><xsl:value-of select="fc:name"/></h2>
        <div class="team-stats">
            <div>Category: <strong><xsl:value-of select="fc:ageCategory"/></strong></div>
            <div>Players: <strong><xsl:value-of select="$playerCount"/></strong></div>
            <div>Coach: <strong><xsl:value-of select="//fc:coach[@id=current()/fc:coachRef/@refId]/fc:firstName"/> <xsl:value-of select="//fc:coach[@id=current()/fc:coachRef/@refId]/fc:lastName"/></strong></div>
        </div>
      </div>

      <div class="team-body">
        <div class="position-grid">
          <!-- Goalkeeper section -->
          <div class="position-box goalkeeper">
            <div class="position-title">
              🥅 Goalkeeper
              <span class="position-count">
                <xsl:value-of select="count(//fc:player[@teamRef=$teamId and fc:position='Goalkeeper'])"/>
              </span>
            </div>
            <xsl:choose>
              <xsl:when test="//fc:player[@teamRef=$teamId and fc:position='Goalkeeper']">
                <xsl:apply-templates select="//fc:player[@teamRef=$teamId and fc:position='Goalkeeper']" mode="position-list"/>
              </xsl:when>
              <xsl:otherwise>
                <div class="no-players">No players in this position</div>
              </xsl:otherwise>
            </xsl:choose>
          </div>

          <!-- Defender section -->
          <div class="position-box defender">
            <div class="position-title">
              🛡️ Defender
              <span class="position-count">
                <xsl:value-of select="count(//fc:player[@teamRef=$teamId and fc:position='Defender'])"/>
              </span>
            </div>
            <xsl:choose>
              <xsl:when test="//fc:player[@teamRef=$teamId and fc:position='Defender']">
                <xsl:apply-templates select="//fc:player[@teamRef=$teamId and fc:position='Defender']" mode="position-list">
                  <xsl:sort select="fc:jerseyNumber" data-type="number"/>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <div class="no-players">No players in this position</div>
              </xsl:otherwise>
            </xsl:choose>
          </div>

          <!-- Midfielder section -->
          <div class="position-box midfielder">
            <div class="position-title">
              ⚙️ Midfielder
              <span class="position-count">
                <xsl:value-of select="count(//fc:player[@teamRef=$teamId and fc:position='Midfielder'])"/>
              </span>
            </div>
            <xsl:choose>
              <xsl:when test="//fc:player[@teamRef=$teamId and fc:position='Midfielder']">
                <xsl:apply-templates select="//fc:player[@teamRef=$teamId and fc:position='Midfielder']" mode="position-list">
                  <xsl:sort select="fc:jerseyNumber" data-type="number"/>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <div class="no-players">No players in this position</div>
              </xsl:otherwise>
            </xsl:choose>
          </div>

          <!-- Forward section -->
          <div class="position-box forward">
            <div class="position-title">
              ⚡ Forward
              <span class="position-count">
                <xsl:value-of select="count(//fc:player[@teamRef=$teamId and fc:position='Forward'])"/>
              </span>
            </div>
            <xsl:choose>
              <xsl:when test="//fc:player[@teamRef=$teamId and fc:position='Forward']">
                <xsl:apply-templates select="//fc:player[@teamRef=$teamId and fc:position='Forward']" mode="position-list">
                  <xsl:sort select="fc:jerseyNumber" data-type="number"/>
                </xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <div class="no-players">No players in this position</div>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Template for player in position list -->
  <xsl:template match="fc:player" mode="position-list">
    <div class="player-in-position">
      <span class="player-number">#<xsl:value-of select="fc:jerseyNumber"/></span>
      <span><xsl:value-of select="fc:firstName"/> <xsl:value-of select="fc:lastName"/></span>
      <xsl:if test="@isCaptain='true'">
        <span class="player-captain"> 👑 CAPTAIN</span>
      </xsl:if>
    </div>
  </xsl:template>

</xsl:stylesheet>
