import 'package:cash_ui/cash_glass_header.dart';
import 'package:cash_ui/cash_input.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/contact/presentation/widgets/cash_contact_list_item.dart';
import 'package:cashual/features/contact/presentation/widgets/cash_contact_section_header.dart';
import 'package:flutter/cupertino.dart';

const _kEthLogo =
    "https://upload.wikimedia.org/wikipedia/commons/f/fd/Ethereum_Logo.png";
const _kBtcLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/3840px-Bitcoin.svg.png";

typedef _Contact = ({
  String imageUrl,
  String name,
  String address,
  String? badgeImageUrl,
});

typedef _ContactGroup = ({String letter, List<_Contact> contacts});

const _kContactGroups = <_ContactGroup>[
  (
    letter: "A",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Amanda",
        name: "Amanda Torres",
        address: "0x8a3f...19cd",
        badgeImageUrl: _kEthLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Andre",
        name: "Andre Walsh",
        address: "bc1q...2c90",
        badgeImageUrl: _kBtcLogo,
      ),
    ],
  ),
  (
    letter: "B",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Brian",
        name: "Brian Cole",
        address: "bc1q...4x2z",
        badgeImageUrl: _kBtcLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Bianca",
        name: "Bianca Ford",
        address: "0x2ab1...66e2",
        badgeImageUrl: _kEthLogo,
      ),
    ],
  ),
  (
    letter: "C",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Chloe",
        name: "Chloe Bennett",
        address: "0x1d9e...77aa",
        badgeImageUrl: _kEthLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Carlos",
        name: "Carlos Rivera",
        address: "bc1q...88fh",
        badgeImageUrl: _kBtcLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Chris",
        name: "Chris Nguyen",
        address: "0x552b...0e31",
        badgeImageUrl: null,
      ),
    ],
  ),
  (
    letter: "D",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Diana",
        name: "Diana Park",
        address: "0x9f0a...c412",
        badgeImageUrl: _kEthLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Derek",
        name: "Derek Simmons",
        address: "bc1q...5f81",
        badgeImageUrl: _kBtcLogo,
      ),
    ],
  ),
  (
    letter: "E",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Elena",
        name: "Elena Cruz",
        address: "0x77bd...1a4f",
        badgeImageUrl: _kEthLogo,
      ),
    ],
  ),
  (
    letter: "G",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Grace",
        name: "Grace Lin",
        address: "0x0f3c...8892",
        badgeImageUrl: _kEthLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Gavin",
        name: "Gavin Brooks",
        address: "bc1q...d217",
        badgeImageUrl: _kBtcLogo,
      ),
    ],
  ),
  (
    letter: "J",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Jason",
        name: "Jason Miller",
        address: "bc1q...aa03",
        badgeImageUrl: _kBtcLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Julia",
        name: "Julia Santos",
        address: "0x33fc...9821",
        badgeImageUrl: _kEthLogo,
      ),
    ],
  ),
  (
    letter: "K",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Kevin",
        name: "Kevin Hart",
        address: "0x8e21...0044",
        badgeImageUrl: null,
      ),
    ],
  ),
  (
    letter: "M",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Marcus",
        name: "Marcus Webb",
        address: "0x71ab...2f6d",
        badgeImageUrl: _kEthLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Maya",
        name: "Maya Patel",
        address: "bc1q...9931",
        badgeImageUrl: _kBtcLogo,
      ),
    ],
  ),
  (
    letter: "N",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Nathan",
        name: "Nathan Reed",
        address: "0x412a...c701",
        badgeImageUrl: _kEthLogo,
      ),
    ],
  ),
  (
    letter: "R",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Rachel",
        name: "Rachel Kim",
        address: "bc1q...7720",
        badgeImageUrl: _kBtcLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Ryan",
        name: "Ryan Osei",
        address: "0x99c4...3bd0",
        badgeImageUrl: _kEthLogo,
      ),
    ],
  ),
  (
    letter: "S",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Sophie",
        name: "Sophie Turner",
        address: "0x0044...bd91",
        badgeImageUrl: _kEthLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Samuel",
        name: "Samuel Ortiz",
        address: "bc1q...f701",
        badgeImageUrl: _kBtcLogo,
      ),
    ],
  ),
  (
    letter: "T",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Tara",
        name: "Tara Nolan",
        address: "0x603d...2299",
        badgeImageUrl: _kEthLogo,
      ),
    ],
  ),
  (
    letter: "W",
    contacts: [
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Wesley",
        name: "Wesley Grant",
        address: "bc1q...4482",
        badgeImageUrl: _kBtcLogo,
      ),
      (
        imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Whitney",
        name: "Whitney Bloom",
        address: "0x2f10...aa77",
        badgeImageUrl: null,
      ),
    ],
  ),
];

class CashContactsScreen extends StatelessWidget {
  const CashContactsScreen({super.key});

  static const _searchBarHeight = 12.0 + 40.0 + 12.0;

  @override
  Widget build(BuildContext context) {
    final schema = CashTheme.schemeOf(context);
    final chromeHeight = CashGlassHeader.totalHeight(
      context,
      bottomHeight: _searchBarHeight,
    );

    return CupertinoPageScaffold(
      backgroundColor: schema.background,
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(16, chromeHeight - 8, 16, 16),
            children: [
              for (final group in _kContactGroups) ...[
                CashContactSectionHeader(letter: group.letter),
                for (final (index, contact) in group.contacts.indexed) ...[
                  if (index > 0) const SizedBox(height: 16),
                  CashContactListItem(
                    imageUrl: contact.imageUrl,
                    name: contact.name,
                    address: contact.address,
                    badgeImageUrl: contact.badgeImageUrl,
                  ),
                ],
              ],
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CashGlassHeader(
              title: "Contacts",
              bottom: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: CashInput(
                  size: .md,
                  radius: CashRadius.xxl,
                  placeholder: "Enter the contact name",
                  startContent: Icon(CupertinoIcons.search),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
