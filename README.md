public_vending_machine


# Vending Machine em SystemVerilog

## Descrição

Este projeto implementa uma **máquina de vendas (Vending Machine)** utilizando **SystemVerilog**, modelada por meio de uma **Máquina de Estados Finitos (FSM)**. O sistema simula o funcionamento de uma máquina de vendas automática, permitindo a inserção de moedas, seleção de produtos, validação da compra, liberação do item, devolução de troco e reembolso em caso de cancelamento.

O projeto foi desenvolvido seguindo uma arquitetura modular, separando a unidade de controle do caminho de dados, o que facilita manutenção, testes e reutilização dos componentes.

---

## Funcionalidades

- Inserção de moedas de R$0,25, R$0,50 e R$1,00;
- Acúmulo do crédito do usuário;
- Seleção de um entre quatro produtos;
- Consulta ao preço e ao estoque do produto;
- Verificação de saldo suficiente para compra;
- Liberação do produto quando a compra é válida;
- Atualização automática do estoque;
- Cálculo e devolução do troco;
- Cancelamento da compra com reembolso integral do crédito;
- Sinalização de erro em caso de saldo insuficiente ou produto indisponível.

---

## Máquina de Estados

O funcionamento do sistema é controlado pelos seguintes estados:

- **IDLE** – aguarda inserção de moedas;
- **COLLECT** – acumula o crédito inserido;
- **CHECK** – verifica preço, estoque e saldo disponível;
- **DISPENSE** – libera o produto e atualiza o estoque;
- **CHANGE** – calcula e devolve o troco;
- **ERROR** – informa erro de compra;
- **REFUND** – devolve todo o crédito ao usuário.

---

## Organização do Projeto

```text
.
├── rtl/
│   ├── vending_pkg.sv
│   ├── vending_top.sv
│   ├── control_unit.sv
│   ├── credit_reg.sv
│   ├── memory.sv
│   ├── comparator.sv
│   └── subtractor.sv
│
├── tb/
│   └── tb_vending.sv
│
├── synth/
│   └── synth.tcl
│
└── Makefile
```

---

## Principais módulos

| Módulo | Função |
|---------|--------|
| **vending_top** | Integra todos os módulos do projeto. |
| **control_unit** | Implementa a máquina de estados responsável pelo controle do sistema. |
| **credit_reg** | Armazena e atualiza o crédito acumulado pelo usuário. |
| **memory** | Armazena preço e estoque dos produtos. |
| **comparator** | Verifica se há saldo suficiente e disponibilidade em estoque. |
| **subtractor** | Calcula o valor do troco. |
| **vending_pkg** | Contém definições compartilhadas, como os estados da FSM e funções auxiliares. |

---

# Simulação

O projeto utiliza o simulador **Synopsys VCS** e o visualizador de formas de onda **Verdi**.

## Verificar sintaxe

Compila todos os arquivos RTL e o testbench, realizando apenas a verificação de sintaxe.

```bash
make syntax
```

---

## Compilar

Realiza a compilação completa do projeto.

```bash
make compile
```

---

## Executar a simulação

Compila o projeto (caso necessário) e executa a simulação.

```bash
make run
```

---

## Visualizar as formas de onda

Abre o arquivo de waveform (`vending.fsdb`) utilizando o Verdi.

```bash
make wave
```

---

# Síntese

A síntese lógica é realizada utilizando o **Synopsys Design Compiler**.

```bash
make synth
```

Esse comando executa automaticamente o script:

```text
synth/synth.tcl
```

responsável por:

- leitura do RTL;
- configuração das bibliotecas;
- aplicação das restrições temporais;
- compilação do circuito;
- geração dos relatórios de área, potência e temporização;
- geração do netlist sintetizado.

---

# Limpeza dos arquivos

### Remover arquivos da simulação

```bash
make clean_sim
```

Remove arquivos temporários gerados pelo VCS e pelo Verdi, incluindo:

- executáveis (`simv`);
- diretórios temporários;
- logs;
- arquivos `.fsdb`;
- banco de dados do Verdi.

---

### Remover arquivos da síntese

```bash
make clean_synth
```

Remove arquivos gerados durante a síntese, como:

- netlists sintetizados;
- arquivos `.ddc`;
- relatórios (`.rpt`);
- bibliotecas intermediárias;
- arquivos SVF.

---

### Limpeza completa

```bash
make clean
```

Remove todos os arquivos gerados durante a simulação e a síntese.

---

# Dependências

Para executar todas as funcionalidades do projeto são necessárias as seguintes ferramentas:

- Synopsys VCS
- Synopsys Verdi
- Synopsys Design Compiler

---

# Fluxo de utilização

```text
make syntax
      │
      ▼
make compile
      │
      ▼
make run
      │
      ▼
make wave

ou

make synth
```

---

# Autor
Ana Lívia Meira
Projeto desenvolvido como trabalho da Residencia em microeletronica CI-Expert, utilizando SystemVerilog para modelagem RTL, simulação funcional e síntese lógica.

