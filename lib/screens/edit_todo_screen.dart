import 'package:demo_app/model/to_do_model.dart';
import 'package:demo_app/provider/task_provder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ─── Color Palette (same across all screens) ─────────────────────
const kBg        = Color(0xFF0A0A0B);
const kCard      = Color(0xFF1A1A1D);
const kBorder    = Color(0xFF2A2A2E);
const kGold      = Color(0xFFD4A853);
const kGoldLight = Color(0xFFE8C87A);
const kCream     = Color(0xFFF2EAD9);
const kMuted     = Color(0xFF8A8A8F);

class EditToDo extends StatefulWidget {
  final ToDoModel task;
  const EditToDo({super.key, required this.task});

  @override
  State<EditToDo> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _updateTask() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    context.read<TaskProvider>().updateTask(widget.task, title);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF141416),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: kCream, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: kCream,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontFamily: 'Georgia',
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 0.5, color: kBorder),
        ),
      ),

      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Section label ──────────────────────────────
                Row(
                  children: [
                    Container(
                      width: 3, height: 14,
                      decoration: BoxDecoration(
                        color: kGold,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'TASK TITLE',
                      style: TextStyle(
                        color: kMuted,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Text field ────────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kBorder),
                  ),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    style: const TextStyle(
                      color: kCream,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    cursorColor: kGold,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Edit your task…',
                      hintStyle: const TextStyle(color: kMuted, fontSize: 15),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: kMuted, size: 18),
                        onPressed: () => _controller.clear(),
                      ),
                    ),
                    onSubmitted: (_) => _updateTask(),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Character hint ────────────────────────────
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (_, val, __) => Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      '${_controller.text.trim().length} characters',
                      style: const TextStyle(color: kMuted, fontSize: 11.5),
                    ),
                  ),
                ),

                const Spacer(),

                // ── Buttons ───────────────────────────────────
                Row(
                  children: [
                    // Cancel
                    Expanded(
                      child: SizedBox(
                        height: 54,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kMuted,
                            side: const BorderSide(color: kBorder),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Update
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 54,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGold,
                            foregroundColor: kBg,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: _updateTask,
                          icon: const Icon(Icons.check_rounded, size: 20),
                          label: const Text(
                            'Update Task',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
