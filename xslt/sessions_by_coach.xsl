<?xml version="1.0" encoding="UTF-8"?>
<!--
  Scenario 2: Group training sessions by coach
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fc="http://www.dsti.football-club.com"
    
  >

  <xsl:output method="text" indent="yes"/>

  <xsl:key name="coachSessions" match="fc:session" use="fc:coachRef/@refId"/>

  <xsl:template match="/">
  {
    "coaches": [
      <xsl:for-each select="//fc:coach">
      {
        "coachId": "<xsl:value-of select="@id"/>",
        "name": "<xsl:value-of select="fc:firstName"/> <xsl:value-of select="fc:lastName"/>",
        "sessions": [
          <xsl:for-each select="key('coachSessions', @id)">
          {
            "day": "<xsl:value-of select="fc:day"/>",
            "type": "<xsl:value-of select="fc:type"/>",
            "intensity": "<xsl:value-of select="fc:intensity"/>"
          }<xsl:if test="position()!=last()">,</xsl:if>
          </xsl:for-each>
        ]
      }<xsl:if test="position()!=last()">,</xsl:if>
      </xsl:for-each>
    ]
  }
  </xsl:template>

</xsl:stylesheet>