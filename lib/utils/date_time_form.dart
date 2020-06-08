import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

enum Type { date, time, both }

class DateTimeFormField extends FormField<DateTime> {
  final Type inputType;

  final DateFormat format;

  final DateTime initialValue;
  final DateTime firstDate;
  final DateTime lastDate;

  final TextStyle style;
  final TextAlign textAlign;
  final bool autofocus;
  final TextInputAction textInputAction;
  final InputDecoration inputDecoration;
  final TextInputType textInputType;

  final FocusNode focusNode;
  final FormFieldValidator<DateTime> validator;
  final FormFieldSetter<DateTime> onSaved;
  final ValueChanged<DateTime> onFieldSubmitted;

  DateTimeFormField(
      {Key key,
        @required this.format,
        this.inputType = Type.both,
        this.initialValue,
        DateTime firstDate,
        DateTime lastDate,
        bool autovalidate = false,
        FocusNode focusNode,
        this.style,
        this.textAlign = TextAlign.start,
        this.autofocus = false,
        this.textInputAction = TextInputAction.done,
        this.inputDecoration = const InputDecoration(),
        this.textInputType = TextInputType.number,
        this.onFieldSubmitted,
        this.validator,
        this.onSaved})
      : firstDate = firstDate ?? DateTime(1900),
        lastDate = lastDate ?? DateTime(2100),
        focusNode = focusNode ?? FocusNode(),
        super(key: key, autovalidate: autovalidate, validator: validator, onSaved: onSaved, builder: (FormFieldState<DateTime> state) {});

  @override
  FormFieldState<DateTime> createState() => _DateTimeFormFieldState();
}

class _DateTimeFormFieldState extends FormFieldState<DateTime> {
  MaskedTextController _controller;

  @override
  DateTimeFormField get widget => super.widget;

  _DateTimeFormFieldState();

  Future<DateTime> getDateTimeInput() async {
    DateTime initialDate = (this.value != null && this.value.isAfter(widget.firstDate)) ? this.value : DateTime.now();
    return showDatePicker(context: context, initialDate: initialDate, firstDate: widget.firstDate, lastDate: widget.lastDate);
  }

  @override
  void initState() {
    super.initState();
    _controller = MaskedTextController(mask: _getMask(widget.format.pattern.toString()), text: _toString(widget.initialValue, widget.format));
    _controller.addListener(_handleControllerChanged);
    widget.focusNode.addListener(_handleFocus);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    widget.focusNode.removeListener(_handleFocus);
    super.dispose();
  }

  void _handleFocus() {
    if (!widget.focusNode.hasFocus) {
      var date = _toDate(_controller.text, widget.format);
      if (date == null || date.isBefore(widget.firstDate) || date.isAfter(widget.lastDate)) {
        _controller.updateText("");
      }
    }
  }

  void _handleControllerChanged() {
    var date = _toDate(_controller.text, widget.format);
    if (date != null) {
      didChange(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          decoration: widget.inputDecoration.copyWith(icon: Icon(Icons.calendar_today)),
          keyboardType: widget.textInputType,
          style: widget.style,
          textAlign: widget.textAlign,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          textInputAction: widget.textInputAction,
          autovalidate: widget.autovalidate,
          onFieldSubmitted: (value) {
            var date = _toDate(value, widget.format);
            if (widget.onFieldSubmitted != null) {
              return widget.onFieldSubmitted(date);
            }
          },
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator(_toDate(value, widget.format));
            }
            return null;
          },
          onSaved: (value) {
            if (widget.onSaved != null) {
              return widget.onSaved(_toDate(value, widget.format));
            }
          },
        ),
        Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 45,
              height: 45,
              child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    getDateTimeInput().then((dateTime) {
                      if (dateTime != null) _controller.updateText(widget.format.format(dateTime));
                    });
                  },
                  child: Icon(
                    Icons.event,
                    color: Colors.white,
                  )),
            ))
      ],
    );
  }
}

String _toString(DateTime date, DateFormat formatter) {
  if (date != null) {
    try {
      return formatter.format(date);
    } catch (e) {}
  }
  return '';
}

DateTime _toDate(String string, DateFormat formatter) {
  if (string?.isNotEmpty ?? false) {
    try {
      return formatter.parse(string);
    } catch (e) {}
  }
  return null;
}

TimeOfDay _toTime(DateTime date) {
  if (date == null) return null;
  return TimeOfDay.fromDateTime(date);
}

String _getMask(String datePattern) => datePattern.replaceAll(RegExp(r'([dD])|([mM])|([yY])|([hH])'), '0');

DateTime dateFromJson(String json) {
  if (json.contains(".")) {
    json = json.substring(0, json.length - 1);
  }

  return DateTime.parse(json);
}