import SwiftUI

struct InfoView: View {
    private let store = BookingStore.shared

    var body: some View {
        List {
            Section {
                infoRow("Сразу", "Отель Лондон (8 ночей), Брюгге, апартаменты Ле-Зарк 1950 — в Ле-Зарке и Брюгге мало вариантов жилья на пике сезона.")
                infoRow("Сразу", "Евростар Лондон → Париж (13.09) — цены растут по мере заполнения поезда.")
                infoRow("Сразу", "Авиабилеты Москва → Лондон (05.09) и Лион → Москва (27.09) — единым билетом через Стамбул, Turkish Airlines.")
                infoRow("За 6–8 недель", "Harry Potter Studio Tour (08.09) — слоты разбирают за 1,5–2 месяца.")
                infoRow("За 6–8 недель", "Столик в The Farmer's Dog (09.09) — бронь обязательна, закрыт вс/пн.")
                infoRow("За 4–6 недель", "Disney: билеты на даты 15.09 и 16.09 — дешевле на 30–40%, чем в кассе.")
                infoRow("За 4–6 недель", "Отели: Бон, Анси, Шамони, Пре-Сен-Дидье.")
                infoRow("За 2–4 недели", "Aiguille du Midi (слот на 20.09, утро).")
                infoRow("За 2–4 недели", "QC Terme (25.09 вечер + 26.09 день).")
                infoRow("За 2 недели", "Рестораны с бронью: Caves Madeleine, La Cabane des Praz, Baita Ermitage.")
                infoRow("За неделю", "Прогноз погоды на Aiguille du Midi и перевал Пти-Сен-Бернар (дважды).")
            } header: {
                sectionHeader("Что и когда бронировать", icon: "checklist")
            }

            Section {
                Text("Паспорта: Великобритания и Шенген — разные режимы въезда. Срок действия — минимум 6 месяцев с запасом.")
                Text("На машину: свидетельство о регистрации, страховка (действующая в Бельгии, Франции, Италии), права, уточнить МВУ.")
                Text("Мед. страховка на все 23 дня, с покрытием горных активностей.")
                Text("Копии документов — в облако и в телефон.")
            } header: {
                sectionHeader("Документы", icon: "doc.text.fill")
            }

            Section {
                Text("Великобритания — фунты (£), Бельгия/Франция/Италия — евро (€). Наличные почти не нужны, €100–150 на мелочи.")
                Text("Чаевые: Лондон — часто уже включён service charge 12,5%. Бельгия/Франция — сервис включён. Италия — coperto не чаевые.")
                Text("Предупредите банк о маршруте (UK → BE → FR → IT). Держите вторую карту про запас.")
            } header: {
                sectionHeader("Деньги", icon: "eurosign.circle.fill")
            }

            Section {
                weatherRow("Лондон", "+16…+20°C днём", "Вероятны дожди")
                weatherRow("Брюгге", "+15…+19°C днём", "Вечером у каналов свежо")
                weatherRow("Париж и Диснейленд", "+18…+22°C днём", "Комфортно")
                weatherRow("Бон, Анси", "+18…+23°C днём", "Прохладные вечера у воды")
                weatherRow("Шамони, Ле-Зарк", "+12…+18°C днём", "Утром может быть иней")
                weatherRow("Aiguille du Midi (3842 м)", "−5…0°C", "Зимняя одежда даже летом")
                weatherRow("Валле-д'Аоста", "+16…+24°C днём", "Заметно теплее")
            } header: {
                sectionHeader("Погода в сентябре", icon: "cloud.sun.fill")
            }

            Section {
                Text("eSIM с пакетом на Европу вкл. Великобританию на все 23 дня.")
                Text("Disneyland Paris, myLPG.eu, Google Maps (офлайн-карты), Citymapper/TfL Go, Météo-France, Flush.")
            } header: {
                sectionHeader("Связь и приложения", icon: "wifi")
            }

            Section {
                Text("112 — единый номер в Великобритании, Бельгии, Франции и Италии, работает и без SIM.")
                Text("999 — также работает в Великобритании.")
                Text("На французских автострадах эвакуатор вызывайте с оранжевого столбика SOS или по 112 — не самостоятельно.")
            } header: {
                sectionHeader("Экстренные номера", icon: "cross.circle.fill")
            }

            Section {
                budgetRow("Проживание", "€3350–5230", "без Ле-Зарка — своё жильё")
                budgetRow("Еда", "€2290–3660", "23 дня")
                budgetRow("Авиаперелёты Москва⇄маршрут", "€1500–2040", "через Стамбул, Turkish Airlines")
                budgetRow("Транспорт на месте", "€800–1230", "топливо GPL, платные дороги, паркинг")
                budgetRow("Билеты и активности", "€1045–1341", "музеи, аттракционы, термы")
                HStack {
                    Text("Итого").font(Theme.serifHeadline).foregroundStyle(Theme.wine)
                    Spacer()
                    Text("€9 000 – 13 500").font(Theme.serifHeadline).foregroundStyle(Theme.wine)
                }
                .padding(.top, 4)
            } header: {
                sectionHeader("Бюджет поездки (на двоих)", icon: "banknote.fill")
            }

            Section {
                Text("Самый длинный день (Брюгге → Бон, 614 км): при усталости разбейте ночёвкой в Реймсе.")
                Text("Перевал Col du Petit-Saint-Bernard закрыт: используйте тоннель Мон-Блан (~€45).")
                Text("Канатка Aiguille du Midi закрыта: запасной день 21.09, либо поезд Montenvers к леднику.")
                Text("Не нашли GPL: Ram двухтопливный, доедете на бензине; перед горами заправьте оба бака.")
                Text("Дождь в Лондоне: музеи (Британский, Тауэр) — на дождливые дни, Гринвич/Портобелло — на сухие.")
                Text("Несдвигаемые точки: Harry Potter, Farmer's Dog, Disney, QC Terme, авиабилеты. Остальное — гибко.")
            } header: {
                sectionHeader("Если что-то пошло не так — план Б", icon: "lifepreserver.fill")
            }
        }
        .scrollContentBackground(.hidden)
        .background(Theme.paper.ignoresSafeArea())
        .listRowSeparatorTint(Theme.gold.opacity(0.25))
        .safeAreaInset(edge: .top) {
            header
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Справка").font(Theme.serifHeadline).foregroundStyle(Theme.ink)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Theme.eyebrow("На всякий случай")
                .foregroundStyle(Theme.gold)
            Text("Справочник поездки")
                .font(Theme.serifLargeTitle)
                .foregroundStyle(Theme.ink)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Theme.paper)
    }

    private func sectionHeader(_ title: String, icon: String) -> some View {
        Label {
            Text(title)
                .font(.system(size: 12, weight: .bold, design: .serif))
                .tracking(1.2)
        } icon: {
            Image(systemName: icon)
        }
        .foregroundStyle(Theme.gold)
    }

    /// Пункт чек-листа бронирований с отметкой "сделано" — состояние хранится в BookingStore
    /// и переживает перезапуск. Ключ строится из текста пункта: он стабилен, пока не меняется текст.
    private func infoRow(_ when: String, _ text: String) -> some View {
        let key = "checklist-\(text.prefix(40))"
        let isDone = store.isBooked(key)

        return Button {
            if isDone { Haptics.tap() } else { Haptics.success() }
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                store.toggle(key)
            }
        } label: {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20))
                    .foregroundStyle(isDone ? Theme.success : Theme.inkSecondary.opacity(0.5))
                    .padding(.top, 1)

                VStack(alignment: .leading, spacing: 2) {
                    Text(when)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Theme.wine)
                    Text(text)
                        .font(.subheadline)
                        .foregroundStyle(Theme.ink)
                }
                .opacity(isDone ? 0.55 : 1)
            }
        }
        .buttonStyle(.plain)
        .padding(.vertical, 2)
    }

    private func weatherRow(_ region: String, _ temp: String, _ note: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(region).font(.subheadline.weight(.semibold)).foregroundStyle(Theme.ink)
                Spacer()
                Text(temp).font(.subheadline).foregroundStyle(Theme.ink)
            }
            Text(note).font(.caption).foregroundStyle(Theme.inkSecondary)
        }
        .padding(.vertical, 2)
    }

    private func budgetRow(_ label: String, _ amount: String, _ note: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(label).font(.subheadline.weight(.semibold)).foregroundStyle(Theme.ink)
                Spacer()
                Text(amount).font(.subheadline).foregroundStyle(Theme.ink)
            }
            Text(note).font(.caption).foregroundStyle(Theme.inkSecondary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    NavigationStack {
        InfoView()
    }
}
