import 'package:example/inputs/coutries.dart';
import 'package:example/inputs/ready_inputs.dart';
import 'package:flutter/material.dart';

class ReadyPhoneInput extends StatefulWidget {
  const ReadyPhoneInput({
    super.key,
    this.controller,
    required this.onCountryChange,
    this.validator,
    this.initialDialCode,
    this.hintText,
    this.labelText,
    this.textInputAction = TextInputAction.done,
    this.autoFocus = false,
    this.isReadOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.buildCounter,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(Country) onCountryChange;

  final bool autoFocus;
  final bool isReadOnly;
  final String? initialDialCode;
  final String? hintText;
  final String? labelText;
  final TextInputAction textInputAction;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? Function(
    BuildContext, {
    int currentLength,
    bool isFocused,
    int? maxLength,
  })?
  buildCounter;

  @override
  State<ReadyPhoneInput> createState() => _ReadyPhoneInputState();
}

class _ReadyPhoneInputState extends State<ReadyPhoneInput> {
  late Country _selectedCountry;
  late TextEditingController _controller;
  final TextEditingController _searchController = TextEditingController();

  late Locale _locale;
  late List<Country> _filteredCountries;

  final List<Country> _countries = countriesList;

  @override
  void initState() {
    super.initState();
    _locale = WidgetsBinding.instance.platformDispatcher.locale;
    _controller = widget.controller ?? TextEditingController();

    _selectedCountry = _countries.firstWhere(
      (c) => c.dialCode == widget.initialDialCode?.replaceAll("+", ""),
      orElse: () => _countries.first,
    );

    _filteredCountries = List.from(_countries);
  }

  String _getLocalizedName(Country country) {
    return country.nameTranslations[_locale.languageCode] ??
        country.nameTranslations['en']!;
  }

  void _onCountryTap() async {
    _searchController.clear();
    _filteredCountries = List.from(_countries);

    final selected = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      showDragHandle: true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search country',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            _filteredCountries =
                                _countries
                                    .where(
                                      (c) => _getLocalizedName(c)
                                          .toLowerCase()
                                          .contains(value.toLowerCase()),
                                    )
                                    .toList();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredCountries.length,
                        itemBuilder: (_, index) {
                          final country = _filteredCountries[index];
                          return ListTile(
                            title: Text(
                              '${country.flag} ${_getLocalizedName(country)} (+${country.dialCode})',
                            ),
                            onTap: () => Navigator.pop(context, country),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedCountry = selected;
        widget.onCountryChange(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReadyInput(
      controller: _controller,
      readOnly: widget.isReadOnly,
      textInputType: TextInputType.phone,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      autoFocus: widget.autoFocus,
      maxLength: _selectedCountry.maxLength,
      hint: widget.hintText,
      label: widget.labelText,
      buildCounter: widget.buildCounter,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      prefixIcon: GestureDetector(
        onTap: _onCountryTap,
        child: Container(
          alignment: Alignment.center,
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "${_selectedCountry.flag}+${_selectedCountry.dialCode}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
