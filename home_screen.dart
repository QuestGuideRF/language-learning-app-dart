import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/language_card.dart';
import '../widgets/daily_goal_progress.dart';
import '../widgets/lesson_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Изучение языков'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Показать уведомления
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Приветствие
              Text(
                'Привет, ${userProvider.currentUser?.name ?? "Ученик"}!',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 8),
              Text(
                'Продолжайте изучать языки каждый день',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              
              SizedBox(height: 24),
              
              // Прогресс ежедневной цели
              DailyGoalProgress(
                currentProgress: userProvider.currentUser?.dailyProgress ?? 0,
                goalTarget: userProvider.currentUser?.dailyGoal ?? 100,
              ),
              
              SizedBox(height: 24),
              
              // Выбор языка
              Text(
                'Ваши языки',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 12),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: languageProvider.languages.length,
                  itemBuilder: (ctx, i) => LanguageCard(
                    language: languageProvider.languages[i],
                    isSelected: languageProvider.selectedLanguage?.code == 
                               languageProvider.languages[i].code,
                    onTap: () {
                      languageProvider.selectLanguage(languageProvider.languages[i]);
                    },
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
              // Рекомендуемые уроки
              Text(
                'Рекомендуемые уроки',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 12),
              
              // Демо-данные для уроков
              LessonItem(
                title: 'Основы приветствия',
                description: 'Научитесь приветствовать людей и представляться',
                duration: '10 мин',
                progress: 0.0,
                onTap: () {
                  Navigator.of(context).pushNamed('/lesson', arguments: 1);
                },
              ),
              
              SizedBox(height: 12),
              
              LessonItem(
                title: 'Числа от 1 до 10',
                description: 'Изучите базовые числительные',
                duration: '8 мин',
                progress: 0.3,
                onTap: () {
                  Navigator.of(context).pushNamed('/lesson', arguments: 2);
                },
              ),
              
              SizedBox(height: 12),
              
              LessonItem(
                title: 'Цвета и формы',
                description: 'Выучите основные цвета и формы',
                duration: '12 мин',
                progress: 0.7,
                onTap: () {
                  Navigator.of(context).pushNamed('/lesson', arguments: 3);
                },
              ),
              
              SizedBox(height: 24),
              
              // Ежедневная задача
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ежедневная задача',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Повторите 20 слов из прошлого урока'),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/exercise', arguments: {'type': 'daily'});
                      },
                      child: Text('Начать'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}