alphabet = ['А':'Я'...] #создаём массив русского алфавита
num(ch) = findfirst(==(ch), alphabet) # функция перевода букв в номер
lettr(n) = alphabet[n] # функция перевода номера обратно в букву

function gamma(text::String, key::String; decrypt=false) # функция гаммирования. text - исходный текст, key - гамма
    t = uppercase(text) # переводим текст в верхний регистр
    k = replace(uppercase(key), " " => "") # переводим гамму в верхний регистр и удаляем пробелы
    tn = [ch for ch in t] # преобразуем текст в масив символов
    kn = [num.(collect(k))...] # преобразуем ключ в масив номеров букв
    kn = repeat(kn, ceil(Int, length(tn)/length(kn)))[1:length(tn)] # если ключ короче текста, то повторяем его до нужной длинны
    op = decrypt ? (-) : (+) # определяем операцию шифрования или расшифрования

    r = [ # основный цикл шифрования и расшифрования
        ch == ' ' ? ' ' : lettr(mod1(op(num(ch) ,y), length(alphabet))) # если символ пробел, то оставляем его без изменений. 
        for (ch, y) in zip(tn, kn) # иначе берём номер буквы и применяем сложение/вычитание по модулю и переводим обратно в букву
    ]
    return join(r)
end

println("введите текст")
text = readline()
println("введите гамму")
key = readline()
println("выберите действие, 1- шифрование, 2 - дешифрование")
choice = readline()

if choice == "1"
    result = gamma(text, key)
    println("зашифрованный текст $result")
elseif choice == "2"
    result = gamma(text, key, decrypt=true)
    println("расшифрованный текст $result")
else
    println("введите 1 или 2")
end 