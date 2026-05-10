<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT Stylesheet: Club Dashboard
  Description: Summary dashboard displaying club information, key statistics,
               top scorers, upcoming events, and quick metrics
  
  Input: football_club.xml
  Output: HTML - Executive club dashboard
  
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
        <title>Club Dashboard - <xsl:value-of select="//fc:clubInfo/fc:name"/></title>
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
          .header {
            background: #2c3e50;
            color: white;
            padding: 28px;
            border-radius: 4px;
            margin-bottom: 30px;
            border: 1px solid #1a252f;
          }
          .header h1 {
            font-size: 28px;
            margin-bottom: 8px;
            font-weight: 600;
          }
          .club-motto {
            font-size: 13px;
            opacity: 0.8;
            font-style: italic;
          }
          .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
          }
          .stat-card {
            background: white;
            border-radius: 4px;
            padding: 18px;
            text-align: center;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            transition: all 0.2s ease;
          }
          .stat-card:hover {
            border-color: #2c3e50;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
          }
          .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: #2c3e50;
            margin: 8px 0;
          }
          .stat-label {
            font-size: 11px;
            color: #666;
            text-transform: uppercase;
            font-weight: 600;
          }
          .stat-icon {
            font-size: 20px;
            margin-bottom: 4px;
          }
          .content-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 20px;
          }
          .card {
            background: white;
            border-radius: 4px;
            overflow: hidden;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
          }
          .card-header {
            background: #2c3e50;
            color: white;
            padding: 14px 16px;
            font-size: 14px;
            font-weight: 600;
            border-bottom: 1px solid #1a252f;
          }
          .card-body {
            padding: 16px;
          }
          .player-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
            font-size: 12px;
          }
          .player-item:last-child {
            border-bottom: none;
          }
          .player-rank {
            display: inline-block;
            background: #2c3e50;
            color: white;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            text-align: center;
            line-height: 22px;
            font-weight: 600;
            font-size: 11px;
            margin-right: 8px;
          }
          .player-name {
            flex: 1;
            font-weight: 600;
            color: #333;
          }
          .player-stat {
            color: #2c3e50;
            font-weight: 600;
            font-size: 12px;
          }
          .team-item {
            padding: 10px;
            margin-bottom: 8px;
            background: #f8f9fa;
            border-left: 3px solid #2c3e50;
            border-radius: 0;
            font-size: 12px;
          }
          .team-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
          }
          .team-info {
            font-size: 11px;
            color: #666;
          }
          .team-info span {
            margin-right: 12px;
          }
          .facility-item {
            padding: 10px;
            margin-bottom: 8px;
            background: #f8f9fa;
            border-left: 3px solid #2c3e50;
            border-radius: 0;
            font-size: 12px;
          }
          .facility-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
          }
          .facility-type {
            font-size: 10px;
            color: #666;
          }
          .empty-message {
            color: #999;
            font-style: italic;
            text-align: center;
            padding: 15px;
            font-size: 12px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <!-- Header -->
          <div class="header">
            <h1>⚽ <xsl:value-of select="//fc:clubInfo/fc:name"/></h1>
            <div class="club-motto">
              "<xsl:value-of select="//fc:clubInfo/fc:motto"/>"
            </div>
            <div style="margin-top: 10px; font-size: 13px;">
              Founded <xsl:value-of select="//fc:clubInfo/fc:founded"/> • <xsl:value-of select="//fc:clubInfo/fc:address/fc:city"/>, <xsl:value-of select="//fc:clubInfo/fc:address/fc:country"/>
            </div>
          </div>

          <!-- Statistics Grid -->
          <div class="dashboard-grid">
            <div class="stat-card">
              <div class="stat-icon">👥</div>
              <div class="stat-label">Total Players</div>
              <div class="stat-value"><xsl:value-of select="count(//fc:player)"/></div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">🏆</div>
              <div class="stat-label">Teams</div>
              <div class="stat-value"><xsl:value-of select="count(//fc:team)"/></div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">👨‍🏫</div>
              <div class="stat-label">Coaches</div>
              <div class="stat-value"><xsl:value-of select="count(//fc:coach)"/></div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">🏟️</div>
              <div class="stat-label">Facilities</div>
              <div class="stat-value"><xsl:value-of select="count(//fc:facility)"/></div>
            </div>
          </div>

          <!-- Content Cards -->
          <div class="content-grid">
            <!-- Top Scorers -->
            <div class="card">
              <div class="card-header">🥅 Top Scorers (2025)</div>
              <div class="card-body">
                <xsl:variable name="topScorers" select="//fc:player[fc:statistics/fc:goals][count(//fc:player[fc:statistics/fc:goals > current()/fc:statistics/fc:goals]) &lt; 5]"/>
                <xsl:choose>
                  <xsl:when test="$topScorers">
                    <xsl:for-each select="$topScorers">
                      <xsl:sort select="fc:statistics/fc:goals" data-type="number" order="descending"/>
                      <div class="player-item">
                        <span>
                          <span class="player-rank"><xsl:value-of select="position()"/></span>
                          <span class="player-name">
                            <xsl:value-of select="fc:firstName"/> <xsl:value-of select="fc:lastName"/>
                          </span>
                        </span>
                        <span class="player-stat">⚽ <xsl:value-of select="fc:statistics/fc:goals"/></span>
                      </div>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="empty-message">No scorer data available</div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>

            <!-- Top Assistants -->
            <div class="card">
              <div class="card-header">🎯 Top Assistants (2025)</div>
              <div class="card-body">
                <xsl:variable name="topAssists" select="//fc:player[fc:statistics/fc:assists][count(//fc:player[fc:statistics/fc:assists > current()/fc:statistics/fc:assists]) &lt; 5]"/>
                <xsl:choose>
                  <xsl:when test="$topAssists">
                    <xsl:for-each select="$topAssists">
                      <xsl:sort select="fc:statistics/fc:assists" data-type="number" order="descending"/>
                      <div class="player-item">
                        <span>
                          <span class="player-rank"><xsl:value-of select="position()"/></span>
                          <span class="player-name">
                            <xsl:value-of select="fc:firstName"/> <xsl:value-of select="fc:lastName"/>
                          </span>
                        </span>
                        <span class="player-stat">✅ <xsl:value-of select="fc:statistics/fc:assists"/></span>
                      </div>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="empty-message">No assist data available</div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>

            <!-- Teams Overview -->
            <div class="card">
              <div class="card-header">🏅 Teams Overview</div>
              <div class="card-body">
                <xsl:choose>
                  <xsl:when test="//fc:team">
                    <xsl:apply-templates select="//fc:team">
                      <xsl:sort select="fc:ageCategory"/>
                    </xsl:apply-templates>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="empty-message">No teams defined</div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>

            <!-- Facilities -->
            <div class="card">
              <div class="card-header">🏟️ Training Facilities</div>
              <div class="card-body">
                <xsl:choose>
                  <xsl:when test="//fc:facility">
                    <xsl:apply-templates select="//fc:facility" mode="dashboard">
                      <xsl:sort select="fc:name"/>
                    </xsl:apply-templates>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="empty-message">No facilities registered</div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>

            <!-- Recent Matches -->
            <div class="card">
              <div class="card-header">📅 Latest Matches</div>
              <div class="card-body">
                <xsl:variable name="recentMatches" select="//fc:match[@status='played'][count(//fc:match[@status='played' and fc:date > current()/fc:date]) &lt; 3]"/>
                <xsl:choose>
                  <xsl:when test="$recentMatches">
                    <xsl:for-each select="$recentMatches">
                      <xsl:sort select="fc:date" order="descending"/>
                      <div class="team-item">
                        <div class="team-name">
                          <xsl:value-of select="substring(fc:date, 9, 2)"/>/<xsl:value-of select="substring(fc:date, 6, 2)"/>/<xsl:value-of select="substring(fc:date, 1, 4)"/>
                        </div>
                        <div class="team-info">
                          <xsl:value-of select="//fc:team[@id=current()/fc:homeTeam/@ref]/fc:name"/>
                          <strong> <xsl:value-of select="fc:result/fc:homeTeamGoals"/> - <xsl:value-of select="fc:result/fc:awayTeamGoals"/> </strong>
                          <xsl:value-of select="//fc:team[@id=current()/fc:awayTeam/@ref]/fc:name"/>
                        </div>
                      </div>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <div class="empty-message">No recent matches</div>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </div>

            <!-- Club Contact -->
            <div class="card">
              <div class="card-header">📍 Club Information</div>
              <div class="card-body">
                <div class="team-item">
                  <div class="team-name">📍 <xsl:value-of select="//fc:clubInfo/fc:address/fc:street"/></div>
                  <div class="team-info">
                    <span><xsl:value-of select="//fc:clubInfo/fc:address/fc:postalCode"/> <xsl:value-of select="//fc:clubInfo/fc:address/fc:city"/></span>
                  </div>
                </div>
                <div class="team-item">
                  <div class="team-name">🌐 Website</div>
                  <div class="team-info">
                    <a href="{//fc:clubInfo/fc:website}" target="_blank"><xsl:value-of select="//fc:clubInfo/fc:website"/></a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template for team in dashboard -->
  <xsl:template match="fc:team">
    <xsl:variable name="teamId" select="@id"/>
    <div class="team-item">
      <div class="team-name"><xsl:value-of select="fc:name"/></div>
      <div class="team-info">
        <span>🏷️ <xsl:value-of select="fc:ageCategory"/></span>
        <span>👥 <xsl:value-of select="count(//fc:player[@teamRef=$teamId])"/> players</span>
      </div>
    </div>
  </xsl:template>

  <!-- Template for facility in dashboard -->
  <xsl:template match="fc:facility" mode="dashboard">
    <div class="facility-item">
      <div class="facility-name"><xsl:value-of select="fc:name"/></div>
      <div class="facility-type">
        📍 <xsl:value-of select="fc:location"/> • <xsl:value-of select="fc:type"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
