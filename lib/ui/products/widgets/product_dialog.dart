import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockly/domain/models/product/product.dart';
import 'package:stockly/ui/core/themes/colors.dart';

class ProductDialog extends StatefulWidget {
  const ProductDialog({
    super.key,
    required this.onPressed,
    this.product,
  });
  final Product? product;
  final Future<void> Function(String name, double price, int stock) onPressed;

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  double price = 0.0;

  @override
  void initState() {
    super.initState();
    price = widget.product?.price ?? 0;
    priceController.text = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      name: 'BRL',
      decimalDigits: 2,
    ).format(price);

    priceController.addListener(_formatPriceInput);
    nameController.text = widget.product?.name ?? '';
    stockController.text = widget.product?.stock.toString() ?? '1';
  }

  @override
  void dispose() {
    priceController.removeListener(_formatPriceInput);
    priceController.dispose();
    super.dispose();
  }

  void _formatPriceInput() {
    String text = priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.isEmpty) text = '0';

    double parsedValue = double.parse(text) / 100;

    final formattedValue = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      name: 'BRL',
      decimalDigits: 2,
    ).format(parsedValue);

    // Evita a reinserção contínua do valor
    if (formattedValue != priceController.text) {
      priceController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
      price = parsedValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 5,
                bottom: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameController.text.isNotEmpty
                        ? 'Editar Produto'
                        : 'Novo Produto',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('Insira as informações abaixo'),
                ],
              ),
            ),
            Column(
              spacing: 30,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Digite o nome do Produto',
                  labelText: 'Nome do Produto',
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Nome do produto é obrigatório.',
                  keyboardType: TextInputType.text,
                ),
                CustomTextFormField(
                  controller: priceController,
                  labelText: 'Preço (R\$)',
                  validator: (value) => price > 0
                      ? null
                      : 'Preço do produto deve ser maior que 0.',
                ),
                CustomTextFormField(
                  controller: stockController,
                  labelText: 'Estoque',
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      Navigator.pop(context);
                      await widget.onPressed(
                        nameController.text,
                        price,
                        int.tryParse(stockController.text) ?? 1,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    this.controller,
    this.hintText,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.number,
    this.onChanged,
  });

  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final String labelText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function(String value)? onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        label: Text(widget.labelText),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue1),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
      ),
      validator: widget.validator,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
    );
  }
}
