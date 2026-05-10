<?xml version="1.0" encoding="UTF-8"?>
<!--
  Scenario 1: Extract active members and output JSON
  Description: This stylesheet retrieves all memberships with status 'Active'
  and links them to player information.
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fc="http://www.dsti.football-club.com"
>

  <xsl:output method="text" indent="yes"/>

  <xsl:template match="/">
    {
      "activeMembers": [
        <xsl:for-each select="//fc:membership[fc:status='Active']">
        {
          "membershipId": "<xsl:value-of select="@id"/>",
          "type": "<xsl:value-of select="fc:type"/>",
          "player": {
            "id": "<xsl:value-of select="fc:memberRef/@refId"/>",
            "name": "<xsl:value-of select="//fc:player[@id=current()/fc:memberRef/@refId]/fc:firstName"/> <xsl:value-of select="//fc:player[@id=current()/fc:memberRef/@refId]/fc:lastName"/>"
          }
        }<xsl:if test="position()!=last()">,</xsl:if>
        </xsl:for-each>
      ]
    }
</xsl:template>


</xsl:stylesheet>
