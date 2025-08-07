import 'package:example/inputs/coutries.dart';
import 'package:example/inputs/ready_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.autovalidateMode,
    this.inputFormatters,
    this.cursorStyle,
    this.decorationType = InputDecorationType.outlined,
    this.enableInteractiveSelection = true,
    this.enableSuggestions = true,
    this.enabled = true,
    this.expands,
    this.focusNode,
    this.isObscure,
    this.onEditingComplete,
    this.onTap,
    this.scrollPadding,
    this.showLabelInside,
    this.style,
    this.suffixIcon,
    this.textAlign,
    this.textAlignVertical,
    this.textCapitalization,
    this.borderRadius,
    this.countries,
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

  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final CursorStyleData? cursorStyle;
  final InputDecorationType decorationType;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final bool enabled;
  final bool? expands;
  final FocusNode? focusNode;
  final bool? isObscure;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final EdgeInsets? scrollPadding;
  final bool? showLabelInside;
  final TextStyle? style;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization? textCapitalization;
  final BorderRadius? borderRadius;
  final List<Country>? countries;

  @override
  State<ReadyPhoneInput> createState() => _ReadyPhoneInputState();
}

class _ReadyPhoneInputState extends State<ReadyPhoneInput> {
  late Country _selectedCountry;
  late TextEditingController _controller;
  final TextEditingController _searchController = TextEditingController();

  late Locale _locale;
  late List<Country> _filteredCountries;

  late final List<Country> _countries;

  @override
  void initState() {
    super.initState();
    _locale = WidgetsBinding.instance.platformDispatcher.locale;
    _controller = widget.controller ?? TextEditingController();
    _countries = widget.countries ?? countriesList;

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
      borderRadius: widget.borderRadius,
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
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: widget.inputFormatters,
      cursorStyle: widget.cursorStyle,
      decorationType: widget.decorationType,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableSuggestions: widget.enableSuggestions,
      enabled: widget.enabled,
      expands: widget.expands ?? false,
      focusNode: widget.focusNode,
      isObscure: widget.isObscure ?? false,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
      showLabelInside: widget.showLabelInside ?? true,
      style: widget.style,
      suffixIcon: widget.suffixIcon,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
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
