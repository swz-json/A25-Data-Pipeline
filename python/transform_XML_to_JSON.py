from lxml import etree

# Charger XML
xml = etree.parse("../football_club.xml")

# Charger XSD
xsd = etree.XMLSchema(etree.parse("../schema.xsd"))

# Validation
if xsd.validate(xml):
    print(" XML valide")
else:
    print(" XML invalide")
    print(xsd.error_log)

# Charger XSLT (scenario 1)
xslt = etree.parse("../xslt/active_members.xsl")
transform = etree.XSLT(xslt)

# Transformation
result = transform(xml)

# Sauvegarde JSON
with open("../output/active_members.json", "w", encoding="utf-8") as f:
    f.write(str(result))

print(" active_members.json généré")

# ===== SCENARIO 2 =====

xslt2 = etree.parse("../xslt/sessions_by_coach.xsl")
transform2 = etree.XSLT(xslt2)

result2 = transform2(xml)

with open("../output/sessions.json", "w", encoding="utf-8") as f:
    f.write(str(result2))

print("sessions.json généré")