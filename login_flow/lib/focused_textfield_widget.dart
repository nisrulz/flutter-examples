import 'package:flutter/material.dart';

class FocusedTextfieldWidget extends StatefulWidget {
  const FocusedTextfieldWidget({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required FocusNode focusedNode,
    @required TextEditingController textController,
    @required String hintText,
    @required Icon prefixIcon,
    @required Function onFieldSubmitted,
    bool obscureText = false,
  })  : _formKey = formKey,
        _focusedNode = focusedNode,
        _textController = textController,
        _prefixIcon = prefixIcon,
        _hintText = hintText,
        _obscureText = obscureText,
        _onFieldSubmitted = onFieldSubmitted,
        super(key: key);

  final FocusNode _focusedNode;
  final TextEditingController _textController;
  final String _hintText;
  final Icon _prefixIcon;
  final bool _obscureText;
  final GlobalKey<FormState> _formKey;
  final Function _onFieldSubmitted;

  @override
  _FocusedTextfieldWidgetState createState() => _FocusedTextfieldWidgetState();
}

class _FocusedTextfieldWidgetState extends State<FocusedTextfieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // override textfield's icon color when selected
        primaryColor: Colors.grey,
      ),
      child: Container(
        decoration: widget._focusedNode.hasFocus
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    offset: Offset(5.0, 5.0),
                    blurRadius: 10.0,
                    spreadRadius: 4.0,
                  ),
                ],
              )
            : null,
        child: Form(
          key: widget._formKey,
          child: TextFormField(
            // controller: _textController,
            focusNode: widget._focusedNode,
            textInputAction: TextInputAction.done,
            obscureText: widget._obscureText,

            //autofocus: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
              prefixIcon: widget._prefixIcon,
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                // gapPadding: 20.0,

                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[350],
                ),
              ),
              hintText: widget._hintText,
            ),
            onFieldSubmitted: widget._onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}
