import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/taskmodel.dart';
import 'package:to_do_app/controller/cubit/task_cubit.dart';
// تأكد من صحة المسارات لديك
// import 'package:to_do_app/Models/taskmodel.dart';
// import 'package:to_do_app/controller/cubit/task_cubit.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
          scaffoldBackgroundColor: const Color(0xff020617), // خلفية أغمق وأفخم
        ),
        home: const TodoScreen(),
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // إضافة إضاءة خفيفة في زاوية الشاشة
          gradient: RadialGradient(
            center: const Alignment(-0.8, -0.7),
            radius: 0.8,
            colors: [
              const Color(0xff7C3AED).withOpacity(0.08),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              final totalTasks = state.taskslist.length;
              final completedTasks = state.taskslist
                  .where((e) => e.isCompleted)
                  .length;
              final progress = totalTasks == 0
                  ? 0.0
                  : completedTasks / totalTasks;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildHeader(completedTasks, totalTasks),
                    const SizedBox(height: 35),
                    _buildProgressCard(progress, completedTasks, totalTasks),
                    const SizedBox(height: 35),
                    _buildInputArea(context),
                    const SizedBox(height: 35),
                    const Text(
                      "Your Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTaskList(state.taskslist),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // الهيدر بتصميم أنيق
  Widget _buildHeader(int completed, int total) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xff8B5CF6), Color(0xff6366F1)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff8B5CF6).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Manager",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Level up your productivity",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // كارت التقدم الاحترافي
  Widget _buildProgressCard(double progress, int completed, int total) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff7C3AED), Color(0xff4F46E5)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff4F46E5).withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Daily Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$completed",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 4),
                child: Text(
                  "/ $total tasks",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                height: 10,
                width: (MediaQuery.of(context).size.width - 104) * progress,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // منطقة الإدخال
  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xff1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Plan something...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<TaskCubit>().addTask(
                  Taskmodel(
                    title: controller.text.trim(),
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                  ),
                );
                controller.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff8B5CF6), Color(0xff6366F1)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // قائمة المهام بـ Animations
  Widget _buildTaskList(List tasks) {
    if (tasks.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome_motion_rounded,
                size: 80,
                color: Colors.white.withOpacity(0.05),
              ),
              const SizedBox(height: 10),
              Text(
                "Clean Slate!",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.2),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: task.isCompleted
                  ? const Color(0xff1E293B).withOpacity(0.5)
                  : const Color(0xff1E293B),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: task.isCompleted
                    ? Colors.green.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.read<TaskCubit>().toggleTask(task.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted
                          ? Colors.green
                          : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted
                            ? Colors.green
                            : Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: task.isCompleted
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                    child: Text(task.title),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      context.read<TaskCubit>().removetask(task.id),
                  icon: Icon(
                    Icons.delete_sweep_rounded,
                    color: Colors.red.withOpacity(0.5),
                    size: 22,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
