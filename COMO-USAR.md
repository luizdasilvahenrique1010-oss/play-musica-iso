# Play Música – ISO do Jukebox

Gera uma ISO bootável (Debian 12) que liga o computador **direto no seu jukebox**, em tela cheia, com os
drivers de áudio, vídeo (placas Intel/AMD/NVIDIA-nouveau), firmwares de som/rede e codecs (mp3, mp4, mkv…)
baixados automaticamente pelo GitHub durante a geração.

## 1) Subir para o GitHub
1. Crie um repositório (pode ser privado) e envie **todo o conteúdo desta pasta** (use "Add file → Upload files"
   ou `git push`). A pasta `.github` precisa subir junto.
2. Aba **Actions** → "Gerar ISO do Play Musica" → **Run workflow**.
3. Demora ~20–40 min. A ISO aparece em **Releases** (lado direito da página do repositório).

## 2) Onde ficam as músicas (escolha UMA opção)
- **A) Dentro do repositório**: coloque em `jukebox/músicas/` e `jukebox/imagem/` (mesma estrutura de antes).
  Limites do GitHub: cada arquivo < 100 MB e repositório de preferência < 1–2 GB. Serve para bibliotecas pequenas.
- **B) Link de download (recomendado para muita música)**: faça um `.zip` com as pastas `músicas` e `imagem`
  na raiz do zip, hospede num link direto (ex.: Release de outro repositório, Dropbox com `?dl=1`) e, no GitHub:
  *Settings → Secrets and variables → Actions → Variables* → crie `MUSICAS_ZIP_URL` com o link.
  O workflow baixa e coloca dentro da ISO.
- **C) Pendrive/HD separado (mais fácil de atualizar)**: ISO sem músicas. Num pendrive/HD (FAT32, exFAT, NTFS ou ext4)
  crie as pastas `músicas` e `imagem`. Com o jukebox ligado, plugue o pendrive e abra **⚙ Configurações → 📚 Bibliotecas**
  (ou tecla F2): aparece a lista **Sistema (local)** e cada pendrive/HD plugado, separados. Escolha um e ele carrega
  (setas ▲▼ e OK também funcionam). Se o pendrive não tiver a pasta `músicas`, ele carrega todas as pastas de música dele.
  Se a ISO não tiver músicas e houver um único pendrive com `músicas`, ele carrega sozinho ao ligar.

As opções podem ser combinadas. Se a ISO ficar maior que 2 GB, o workflow divide em partes (instruções no Release).

## 3) Gravar e usar
- Grave a ISO num pendrive com **Rufus** (modo "Imagem DD") ou **Ventoy**. Funciona em BIOS e UEFI (64 bits).
- Dê boot por ele. O jukebox abre sozinho. Não precisa de internet.
- Para instalar de vez no PC, grave a ISO num SSD/HD (ou use como pendrive de boot do balcão).

## Observações
- Crédito, configurações e ranking ficam na memória e **zeram ao reiniciar** (sistema "live").
- Sair do jukebox: `Ctrl+Alt+F2` abre um terminal (usuário `jukebox`, senha `live`).
- Pendrives são detectados na hora (a lista de Bibliotecas se atualiza sozinha a cada 3 s) e lidos só em modo leitura.
- Só 64 bits (amd64). Placas NVIDIA usam o driver livre (nouveau).
- Para mudar pacotes/drivers: `build/overlay/package-lists/jukebox.list.chroot`.
- No Windows continua funcionando como antes: `jukebox/INICIAR.bat`.
