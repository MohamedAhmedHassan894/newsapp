import 'package:flutter/cupertino.dart';

class PageModel {
  String _image;
  IconData _icon;
  String _title;
  String _description;

  PageModel(this._image, this._icon , this._title, this._description);

  String get image {
    return _image;
  }

  IconData get icon {
    return _icon;
  }

  String get title {
    return _title;
  }

  String get description {
    return _description;
  }
}