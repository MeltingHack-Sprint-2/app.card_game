import 'package:equatable/equatable.dart';

class FormPropertyItem<T> extends Equatable {
  const FormPropertyItem({
    this.value,
    this.valueInvalidMessage,
    this.valueIsDirty,
  });

  final T? value;
  final bool? valueIsDirty;
  final String? valueInvalidMessage;

  factory FormPropertyItem.create(Set<List<String>> set, {T? value}) {
    if (value == null) return const FormPropertyItem();
    return FormPropertyItem(
        value: value,
        // ignore: unnecessary_null_comparison
        valueIsDirty: value != null,
        valueInvalidMessage: null);
  }

  FormPropertyItem copyWith(
      T? value, String? valueInvalidMessage, bool? valueIsDirty) {
    return FormPropertyItem(
      value: value ?? this.value,
      valueIsDirty: valueIsDirty ?? this.valueIsDirty,
      valueInvalidMessage:
          valueIsDirty == true ? valueInvalidMessage : this.valueInvalidMessage,
    );
  }

  bool get propertyIsValid {
    return valueIsDirty == true && valueInvalidMessage == null;
  }

  @override
  List<Object?> get props => [
        value,
        valueInvalidMessage,
        valueIsDirty,
      ];
}
