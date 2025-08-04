part of 'ready_inputs.dart';

/// A customizable phone input widget with country code selector.
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

  /// Text controller for the phone input.
  final TextEditingController? controller;

  /// Validator function for phone input.
  final String? Function(String?)? validator;

  /// Callback triggered when the country changes.
  final Function(Country) onCountryChange;

  /// Autofocus flag for the input.
  final bool autoFocus;

  /// Make input read-only.
  final bool isReadOnly;

  /// Initial dial code to be selected.
  final String? initialDialCode;

  /// Hint text for the input.
  final String? hintText;

  /// Label text for the input.
  final String? labelText;

  /// Action button for the keyboard.
  final TextInputAction textInputAction;

  /// Called when input value changes.
  final ValueChanged<String>? onChanged;

  /// Called when input is submitted.
  final ValueChanged<String>? onFieldSubmitted;

  /// Optional buildCounter widget.
  final Widget? Function(
    BuildContext,
    {int currentLength, bool isFocused, int? maxLength}
  )? buildCounter;

  /// Validation mode.
  final AutovalidateMode? autovalidateMode;

  /// Input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Custom cursor styling.
  final CursorStyleData? cursorStyle;

  /// Input decoration type.
  final InputDecorationType decorationType;

  /// Enable selection in input.
  final bool enableInteractiveSelection;

  /// Enable text suggestions.
  final bool enableSuggestions;

  /// Enable/disable input.
  final bool enabled;

  /// Expand input vertically.
  final bool? expands;

  /// Custom focus node.
  final FocusNode? focusNode;

  /// Obscure the input (for passwords, etc).
  final bool? isObscure;

  /// Callback when editing is completed.
  final VoidCallback? onEditingComplete;

  /// Callback on input tap.
  final VoidCallback? onTap;

  /// Padding for scroll insets.
  final EdgeInsets? scrollPadding;

  /// Show label inside field.
  final bool? showLabelInside;

  /// Input text style.
  final TextStyle? style;

  /// Custom suffix icon.
  final Widget? suffixIcon;

  /// Text alignment in the input.
  final TextAlign? textAlign;

  /// Vertical text alignment.
  final TextAlignVertical? textAlignVertical;

  /// Text capitalization rules.
  final TextCapitalization? textCapitalization;

  /// Border radius for the input.
  final BorderRadius? borderRadius;

  /// Optional custom country list.
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

    // Detect device locale.
    _locale = WidgetsBinding.instance.platformDispatcher.locale;

    // Use external or internal controller.
    _controller = widget.controller ?? TextEditingController();

    // Use provided or default country list.
    _countries = widget.countries ?? countriesList;

    // Set initial country by dial code, or fallback to first.
    _selectedCountry = _countries.firstWhere(
      (c) => c.dialCode == widget.initialDialCode?.replaceAll("+", ""),
      orElse: () => _countries.first,
    );

    // Initialize filter list for search.
    _filteredCountries = List.from(_countries);
  }

  /// Get localized name of a country based on current locale.
  String _getLocalizedName(Country country) {
    return country.nameTranslations[_locale.languageCode] ??
        country.nameTranslations['en']!;
  }

  /// Show bottom sheet for country picker.
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
                    // Search input.
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
                            _filteredCountries = _countries
                                .where((c) => _getLocalizedName(c)
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),

                    // Country list.
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

    // Update selected country on result.
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
      showLabelInside: widget.showLabelInside ?? false,
      style: widget.style,
      suffixIcon: widget.suffixIcon,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,

      // Country prefix button.
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
