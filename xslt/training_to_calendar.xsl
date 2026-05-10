<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fc="http://www.dsti.football-club.com"
    xmlns:cal="http://www.example.com/xml/training-calendar"
    exclude-result-prefixes="fc">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <cal:trainingCalendar>
      <xsl:attribute name="clubName">
        <xsl:value-of select="fc:footballClub/fc:clubInfo/fc:name"/>
      </xsl:attribute>
      <xsl:apply-templates select="fc:footballClub/fc:trainingSessions/fc:session"/>
    </cal:trainingCalendar>
  </xsl:template>

  <xsl:template match="fc:session">
    <cal:session>
      <xsl:attribute name="sessionId">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="teamId">
        <xsl:value-of select="fc:teamRef/@refId"/>
      </xsl:attribute>
      <cal:schedule>
        <xsl:attribute name="day">
          <xsl:value-of select="fc:day"/>
        </xsl:attribute>
        <xsl:attribute name="start">
          <xsl:value-of select="fc:startTime"/>
        </xsl:attribute>
        <xsl:attribute name="end">
          <xsl:value-of select="fc:endTime"/>
        </xsl:attribute>
      </cal:schedule>
      <cal:focus>
        <xsl:value-of select="fc:type"/>
      </cal:focus>
      <cal:intensity>
        <xsl:value-of select="fc:intensity"/>
      </cal:intensity>
      <cal:description>
        <xsl:value-of select="fc:description"/>
      </cal:description>
      <cal:coachId>
        <xsl:value-of select="fc:coachRef/@refId"/>
      </cal:coachId>
      <cal:facilityId>
        <xsl:value-of select="fc:facilityRef/@refId"/>
      </cal:facilityId>
    </cal:session>
  </xsl:template>

</xsl:stylesheet>
