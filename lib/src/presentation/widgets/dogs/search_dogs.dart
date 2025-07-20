import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/logic/api_cubit/dog/api_dog_cubit.dart';

class SearchDogs extends StatefulWidget {
  const SearchDogs({super.key});

  @override
  State<SearchDogs> createState() => _SearchDogsState();
}

class _SearchDogsState extends State<SearchDogs> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    context.read<ApiDogCubit>().searchDogs('');
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        autofocus: false,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Search for dogs...',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.cardBackground,
          suffixIcon: _buildSuffixIcon(_controller.text),
        ),
        onChanged: (value) {
          context.read<ApiDogCubit>().searchDogs(value);
        },
      ),
    );
  }

  Widget _buildSuffixIcon(String value) {
    if (value.isNotEmpty) {
      return IconButton(
        icon: const Icon(Icons.clear, color: AppColors.accent),
        onPressed: _clearSearch,
      );
    }
    return Icon(Icons.search, color: AppColors.accent);
  }
}
