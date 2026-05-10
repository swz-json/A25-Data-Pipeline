<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT Stylesheet: Match Calendar
  Description: Displays competition schedule with match dates, teams, 
               results, and standings
  
  Input: football_club.xml
  Output: HTML - Competition calendar with results
  
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
        <title>Match Calendar - <xsl:value-of select="//fc:clubInfo/fc:name"/></title>
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
            max-width: 1000px;
            margin: 0 auto;
          }
          h1 {
            color: #1a1a1a;
            margin-bottom: 30px;
            text-align: center;
            font-size: 32px;
            font-weight: 600;
          }
          .competition-section {
            background: white;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            overflow: hidden;
          }
          .comp-header {
            background: #2c3e50;
            color: white;
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }
          .comp-header h2 {
            font-size: 18px;
            margin: 0;
            font-weight: 600;
          }
          .comp-season {
            font-size: 13px;
            opacity: 0.8;
          }
          .matches-list {
            padding: 20px;
          }
          .match-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px;
            margin-bottom: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 2px;
            background: #f8f9fa;
            font-size: 13px;
          }
          .match-card:hover {
            border-color: #2c3e50;
            background: #f0f0f5;
          }
          .match-date {
            min-width: 110px;
            color: #666;
            font-weight: 600;
            text-align: center;
            font-size: 12px;
          }
          .match-teams {
            flex: 1;
            margin: 0 20px;
          }
          .home-team, .away-team {
            display: inline-block;
            width: 40%;
            text-align: center;
            font-weight: 600;
          }
          .match-result {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            min-width: 60px;
            text-align: center;
          }
          .match-result.pending {
            color: #999;
            font-size: 12px;
          }
          .match-location {
            min-width: 140px;
            font-size: 12px;
            color: #666;
            text-align: right;
          }
          .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 2px;
            font-size: 11px;
            font-weight: 600;
            margin-top: 4px;
            text-transform: uppercase;
          }
          .badge.win { background: #d4edda; color: #155724; }
          .badge.loss { background: #f8d7da; color: #721c24; }
          .badge.draw { background: #fff3cd; color: #856404; }
          .badge.pending { background: #e2e3e5; color: #383d41; }
          .no-matches {
            text-align: center;
            padding: 20px;
            color: #999;
            font-style: italic;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>📅 Match Calendar</h1>
          
          <xsl:apply-templates select="//fc:competition">
            <xsl:sort select="fc:season" order="descending"/>
          </xsl:apply-templates>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template for each competition -->
  <xsl:template match="fc:competition">
    <div class="competition-section">
      <div class="comp-header">
        <div>
          <h2><xsl:value-of select="fc:name"/></h2>
          <div class="comp-season">Season: <xsl:value-of select="fc:season"/></div>
        </div>
        <div><xsl:value-of select="fc:type"/></div>
      </div>

      <div class="matches-list">
        <xsl:choose>
          <xsl:when test="fc:match">
            <xsl:apply-templates select="fc:match">
              <xsl:sort select="fc:date" order="ascending"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <div class="no-matches">No matches scheduled</div>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </xsl:template>

  <!-- Template for each match -->
  <xsl:template match="fc:match">
    <xsl:variable name="status" select="@status"/>
    <xsl:variable name="homeGoals" select="fc:result/fc:homeTeamGoals"/>
    <xsl:variable name="awayGoals" select="fc:result/fc:awayTeamGoals"/>
    <xsl:variable name="homeTeamName" select="//fc:team[@id=current()/fc:homeTeam/@ref]/fc:name"/>
    <xsl:variable name="awayTeamName" select="//fc:team[@id=current()/fc:awayTeam/@ref]/fc:name"/>
    
    <div class="match-card">
      <div class="match-date">
        📆 <xsl:value-of select="substring(fc:date, 9, 2)"/>/<xsl:value-of select="substring(fc:date, 6, 2)"/>/<xsl:value-of select="substring(fc:date, 1, 4)"/>
        <br/>
        <small>⏰ <xsl:value-of select="substring(fc:time, 1, 5)"/></small>
      </div>

      <div class="match-teams">
        <div class="home-team">
          <xsl:value-of select="$homeTeamName"/>
        </div>
        <span> vs </span>
        <div class="away-team">
          <xsl:value-of select="$awayTeamName"/>
        </div>
      </div>

      <div class="match-result">
        <xsl:choose>
          <xsl:when test="$status = 'played'">
            <xsl:value-of select="$homeGoals"/> - <xsl:value-of select="$awayGoals"/>
            <br/>
            <xsl:choose>
              <xsl:when test="$homeGoals > $awayGoals">
                <span class="badge win">WIN</span>
              </xsl:when>
              <xsl:when test="$homeGoals &lt; $awayGoals">
                <span class="badge loss">LOSS</span>
              </xsl:when>
              <xsl:otherwise>
                <span class="badge draw">DRAW</span>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <span class="match-result pending">TBD</span>
            <br/>
            <span class="badge pending">PENDING</span>
          </xsl:otherwise>
        </xsl:choose>
      </div>

      <div class="match-location">
        📍 <xsl:value-of select="fc:venue"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
