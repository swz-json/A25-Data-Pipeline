<?xml version="1.0" encoding="UTF-8"?>
<!--
  Transformation XSLT 1.0 : modèle club football (fc) → rapport joueurs (format simplifié).
  Entrée : document validé selon football_club.xsd.
  Sortie : XML avec structure plate orientée « effectif / statistiques ».
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fc="http://www.dsti.football-club.com"
    xmlns:rep="http://www.example.com/xml/club-report"
    exclude-result-prefixes="fc">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <rep:clubReport>
      <!-- XSLT 1.0 : pas de date/heure native ; l’appelant peut ajouter un horodatage -->
      <xsl:attribute name="formatVersion">1.0</xsl:attribute>
      <xsl:attribute name="sourceNamespace">http://www.dsti.football-club.com</xsl:attribute>
      <rep:clubName>
        <xsl:value-of select="fc:footballClub/fc:clubInfo/fc:name"/>
      </rep:clubName>
      <rep:players>
        <xsl:apply-templates select="fc:footballClub/fc:players/fc:player"/>
      </rep:players>
    </rep:clubReport>
  </xsl:template>

  <xsl:template match="fc:player">
    <rep:player>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="captain">
        <xsl:value-of select="@isCaptain"/>
      </xsl:attribute>
      <rep:teamRef>
        <xsl:value-of select="@teamRef"/>
      </rep:teamRef>
      <rep:fullName>
        <xsl:value-of select="concat(fc:firstName, ' ', fc:lastName)"/>
      </rep:fullName>
      <rep:position>
        <xsl:value-of select="fc:position"/>
      </rep:position>
      <rep:jersey>
        <xsl:value-of select="fc:jerseyNumber"/>
      </rep:jersey>
      <xsl:apply-templates select="fc:statistics"/>
    </rep:player>
  </xsl:template>

  <xsl:template match="fc:statistics">
    <rep:seasonStats>
      <xsl:attribute name="season">
        <xsl:value-of select="@season"/>
      </xsl:attribute>
      <rep:matchesPlayed>
        <xsl:value-of select="fc:matchesPlayed"/>
      </rep:matchesPlayed>
      <rep:goals>
        <xsl:value-of select="fc:goals"/>
      </rep:goals>
      <rep:assists>
        <xsl:value-of select="fc:assists"/>
      </rep:assists>
      <rep:minutesPlayed>
        <xsl:value-of select="fc:minutesPlayed"/>
      </rep:minutesPlayed>
    </rep:seasonStats>
  </xsl:template>

</xsl:stylesheet>
