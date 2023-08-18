#  Примерная структура Feature

https://github.com/kudoleh/iOS-Modular-Architecture.git


- Example - Можно добавить Example проект для проверки Feature без запуска всего приложения.

- Sources - Основная директория Package (в target добавляем path: "Sources")
    - Domain 
        - Data/BusinessLogic - Бизнес логика Feature
        - Presentation - То что касается UI
        - ...
    - Public - Побличные assembly, protocols/interfaces, models
    - Resource - Ресурсы Feature
    - ...

- Tests - По возможности пишем тесты.

!!! ВСЕ ДОЛЖНО БЫТЬ INTERNAL, КРОМЕ Public

...
