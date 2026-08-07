# Platform Engineering Learning State

## Aktualny temat

Terraform execution plans i state.

## Rozumiem
- Skąd informacje czerpie terraform plan
- To że terraform doprowadza do określonego stanu jest idempotentny
- terraform validate: sprawdza składnie plików wskazuje gdy np definicja zasobu jest po odniesieniu do niego
- terraform fmt: poprawia formatowanie do stylu terraforma
## Częściowo rozumiem
- terraform import: na bazie id i addressu jest w stanie zaimportować stan do planu - nie rozumiem do końca co oznacza address w dokumentacji. Nie wiem jak zaimportować wszystko, czy wgl się da

## Do powtórzenia
- wszystko żebym miał powtórkę i dobrze rozumiał zagadnienia

## Moje wyjaśnienie

### Terraform plan
na podstawie stanu zasobów zdalnych, kodu i terraform state tworzy plan zmian do wprowadzenia na zasobach zdalnych

### Terraform plan -out=tfplan
Jak wyżej ale zapisuje plan do pliku

### Terraform plan 
Wykonuje operacje które mają doprowadzić do stanu zgodnego z ze stanem zasobów i planem 

### Terraform plan tfplan
Jak wyżej ale na podstawie planu zapisanego w pliku tutaj omijamy problem zmiany zasobów loklanie

## Zrozumiane dzisiaj

- Dlaczego istnieje terraform import.
- Czym jest resource address.
- Dlaczego terraform state jest mapą.
- Co robi terraform state rm.
- Czym jest drift.
- Dlaczego po imporcie celem jest uzyskanie "No changes".