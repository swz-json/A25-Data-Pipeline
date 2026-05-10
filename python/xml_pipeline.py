#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Pipeline XML : chargement d'un document, validation XSD, transformation XSLT.

Dépendance : lxml (libxml2 / libxslt).

    Commande a lancer pour générer les XML de sortie :

    python xml_pipeline.py --xml ./football_club.xml --xsd ./football_club.xsd --xsl ./xslt/players_to_report.xsl --out ./output/rapport_joueurs.xml
    python xml_pipeline.py --xml ./football_club.xml --xsd ./football_club.xsd --xsl ./xslt/training_to_calendar.xsl --out ./output/rapport_calendrier.xml
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from lxml import etree


def load_xml(path: Path) -> etree._ElementTree:
    parser = etree.XMLParser(resolve_entities=False, no_network=True)
    return etree.parse(str(path), parser)


def validate_xsd(tree: etree._ElementTree, xsd_path: Path) -> None:
    """
    Valide l'arbre XML contre le schéma XSD.
    Lève etree.DocumentInvalid si la validation échoue.
    """
    with xsd_path.open("rb") as f:
        schema_doc = etree.parse(f)
    schema = etree.XMLSchema(schema_doc)
    schema.assertValid(tree)


def apply_xslt(tree: etree._ElementTree, xsl_path: Path) -> etree._ElementTree:
    """Applique la feuille XSLT 1.0 et retourne le document résultat."""
    with xsl_path.open("rb") as f:
        xsl_doc = etree.parse(f)
    transform = etree.XSLT(xsl_doc)
    return transform(tree)


def main() -> int:
    p = argparse.ArgumentParser(
        description="Valider un XML contre un XSD puis appliquer une XSLT."
    )
    p.add_argument("--xml", required=True, type=Path, help="Fichier XML d'entrée")
    p.add_argument("--xsd", required=True, type=Path, help="Schéma XSD")
    p.add_argument("--xsl", required=True, type=Path, help="Feuille de style XSLT")
    p.add_argument(
        "--out",
        type=Path,
        help="Fichier XML de sortie (défaut : stdout en UTF-8)",
    )
    p.add_argument(
        "--skip-validation",
        action="store_true",
        help="Ne pas valider le XSD (déconseillé, pour tests uniquement)",
    )
    args = p.parse_args()

    for label, path in ("XML", args.xml), ("XSD", args.xsd), ("XSL", args.xsl):
        if not path.is_file():
            print(f"Erreur : fichier {label} introuvable : {path}", file=sys.stderr)
            return 2

    try:
        tree = load_xml(args.xml)
        if not args.skip_validation:
            validate_xsd(tree, args.xsd)
            print("Validation XSD : OK", file=sys.stderr)
        result = apply_xslt(tree, args.xsl)
        out_bytes = etree.tostring(
            result,
            xml_declaration=True,
            encoding="UTF-8",
            pretty_print=True,
        )
        if args.out:
            args.out.parent.mkdir(parents=True, exist_ok=True)
            args.out.write_bytes(out_bytes)
            print(f"Sortie écrite : {args.out}", file=sys.stderr)
        else:
            sys.stdout.buffer.write(out_bytes)
    except etree.XMLSyntaxError as e:
        print(f"Erreur de parsing XML : {e}", file=sys.stderr)
        return 3
    except etree.DocumentInvalid as e:
        print(str(e), file=sys.stderr)
        return 4
    except etree.XSLTApplyError as e:
        print(f"Erreur XSLT : {e}", file=sys.stderr)
        return 5
    except Exception as e:
        print(f"Erreur : {e}", file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
