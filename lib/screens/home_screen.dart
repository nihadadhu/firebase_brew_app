import 'package:demo_app/provider/task_provder.dart';
import 'package:demo_app/screens/add_todo_screen.dart';
import 'package:demo_app/screens/edit_todo_screen.dart';
import 'package:demo_app/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ─── Color Palette (same across all screens) ─────────────────────
const kBg     = Color(0xFF0A0A0B);
const kCard   = Color(0xFF1A1A1D);
const kBorder = Color(0xFF2A2A2E);
const kGold   = Color(0xFFD4A853);
const kGoldLight = Color(0xFFE8C87A);
const kCream  = Color(0xFFF2EAD9);
const kMuted  = Color(0xFF8A8A8F);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: kBg,

      // ── App Bar ────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFF141416),
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: kCream, size: 22),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text(
          'Todo List',
          style: TextStyle(
            color: kCream,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontFamily: 'Georgia',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorder),
              ),
              child: const Icon(Icons.search_rounded, color: kMuted, size: 18),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 0.5, color: kBorder),
        ),
      ),

      drawer: const AppDrawer(),

      // ── Body ───────────────────────────────────────────────────
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {

          // Loading
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: kGold, strokeWidth: 2),
            );
          }

          // Empty state
          if (provider.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: kCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kBorder),
                    ),
                    child: const Icon(Icons.check_circle_outline_rounded,
                        color: kMuted, size: 34),
                  ),
                  const SizedBox(height: 16),
                  const Text('No tasks yet',
                      style: TextStyle(color: kCream, fontSize: 17,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  const Text('Tap the button below to add one',
                      style: TextStyle(color: kMuted, fontSize: 13)),
                ],
              ),
            );
          }

          // Stats header
          final total     = provider.tasks.length;
          final completed = provider.tasks.where((t) => t.isComplete).length;
          final pending   = total - completed;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [

              // ── Stats row ─────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
                  child: Row(
                    children: [
                      _statChip('Total',     total,     const Color(0xFF6B9EFF)),
                      const SizedBox(width: 10),
                      _statChip('Done',      completed, const Color(0xFF5DC896)),
                      const SizedBox(width: 10),
                      _statChip('Pending',   pending,   const Color(0xFFFF9F5B)),
                    ],
                  ),
                ),
              ),

              // ── Section label ─────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                  child: Row(
                    children: [
                      Container(
                        width: 3, height: 14,
                        decoration: BoxDecoration(
                          color: kGold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('MY TASKS',
                          style: TextStyle(
                            color: kMuted,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          )),
                    ],
                  ),
                ),
              ),

              // ── Task list ─────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 120),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final task = provider.tasks[index];
                      return _TaskTile(
                        task: task,
                        provider: provider,
                        index: index,
                      );
                    },
                    childCount: provider.tasks.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // ── FAB ────────────────────────────────────────────────────
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: kGold,
              foregroundColor: kBg,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddToDo()),
            ),
            icon: const Icon(Icons.add_rounded, size: 22),
            label: const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statChip(String label, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: kBorder),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(color: kMuted, fontSize: 11.5)),
          ],
        ),
      ),
    );
  }
}

// ─── Task Tile ────────────────────────────────────────────────────
class _TaskTile extends StatelessWidget {
  final dynamic task;
  final TaskProvider provider;
  final int index;

  const _TaskTile({
    required this.task,
    required this.provider,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool done = task.isComplete;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: done
                ? const Color(0xFF5DC896).withOpacity(0.3)
                : kBorder,
          ),
        ),
        child: Row(
          children: [

            // ── Checkbox ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: GestureDetector(
                onTap: () => provider.toggleComplete(task, !done),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done
                        ? const Color(0xFF5DC896)
                        : Colors.transparent,
                    border: Border.all(
                      color: done
                          ? const Color(0xFF5DC896)
                          : kBorder,
                      width: 2,
                    ),
                  ),
                  child: done
                      ? const Icon(Icons.check_rounded,
                          color: kBg, size: 14)
                      : null,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // ── Title ───────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: done ? kMuted : kCream,
                    decoration: done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: kMuted,
                  ),
                ),
              ),
            ),

            // ── Menu ────────────────────────────────────────────
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded, color: kMuted, size: 20),
              color: const Color(0xFF1E1E22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: kBorder),
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditToDo(task: task)),
                  );
                } else if (value == 'delete') {
                  provider.deleteTask(task.id);
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          color: kGold.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.edit_outlined,
                            color: kGold, size: 16),
                      ),
                      const SizedBox(width: 10),
                      const Text('Edit',
                          style: TextStyle(color: kCream, fontSize: 14)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF3B30).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.delete_outline_rounded,
                            color: Color(0xFFFF3B30), size: 16),
                      ),
                      const SizedBox(width: 10),
                      const Text('Delete',
                          style: TextStyle(
                              color: Color(0xFFFF3B30), fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
