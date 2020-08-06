__version__ = "0.1.1"

from ._parser import parser
from .rules import *
from .transformer import RuleTransformer


def parse_rules(source: str) -> RulesList:
    tree = parser.parse(source)
    return RuleTransformer().transform(tree)
