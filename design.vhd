library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity RISCV32i is
    Port ( 
        i_CLK      : in  std_logic;
        i_RSTn     : in  std_logic;
        
        -- Debug signals
        o_INST     : out std_logic_vector(31 downto 0);
        o_OPCODE   : out std_logic_vector(6 downto 0);
        o_RD_ADDR  : out std_logic_vector(4 downto 0);
        o_RS1_ADDR : out std_logic_vector(4 downto 0);
        o_RS2_ADDR : out std_logic_vector(4 downto 0);
        o_RS1_DATA : out std_logic_vector(31 downto 0);
        o_RS2_DATA : out std_logic_vector(31 downto 0);
        o_IMM      : out std_logic_vector(31 downto 0);
        o_ULA      : out std_logic_vector(31 downto 0);
        o_MEM      : out std_logic_vector(31 downto 0)
    );
end RISCV32i;

architecture arch_1 of RISCV32i is
    signal w_RS1, w_RS2 : std_logic_vector(31 downto 0);
    signal w_ULA : std_logic_vector(31 downto 0);
    signal w_ULAb : std_logic_vector(31 downto 0);
    signal w_ZERO : std_logic;
    
    -- Data memory signals
    signal w_MEM : std_logic_vector(31 downto 0);
    
    -- Immediate generator signals
    signal w_IMM : std_logic_vector(31 downto 0);
    
    -- PC and instruction memory signals
    signal w_PC, w_PC4 : std_logic_vector(31 downto 0);
    signal w_INST : std_logic_vector(31 downto 0);
    
    -- Control signals
    signal w_ALU_SRC    : std_logic;
    signal w_MEM2REG    : std_logic;
    signal w_REG_WRITE  : std_logic;
    signal w_MEM_READ   : std_logic;
    signal w_MEM_WRITE  : std_logic;
    signal w_ALUOP      : std_logic_vector(1 downto 0);
    
    -- MUX for MEM2REG
    signal w_MUX_MEM2REG : std_logic_vector(31 downto 0);
    
begin
    u_CONTROLE: entity work.controle
    port map (    
        i_OPCODE     => w_INST(6 downto 0),
        o_ALU_SRC    => w_ALU_SRC,
        o_MEM2REG    => w_MEM2REG,
        o_REG_WRITE  => w_REG_WRITE,
        o_MEM_READ   => w_MEM_READ,
        o_MEM_WRITE  => w_MEM_WRITE,
        o_ALUOP      => w_ALUOP
    );

    u_PC: entity work.ffd
    port map (
        i_DATA    => w_PC4,
        i_CLK     => i_CLK,
        i_RSTn    => i_RSTn,
        o_DATA    => w_PC
    );
    
    u_SOMA4 : entity work.somador
    port map (    
        i_A     => w_PC,
        i_B     => X"00000004",
        o_DATA  => w_PC4
    );
    
    u_MEM_INST: entity work.memoria_instrucoes
    port map(
        i_ADDR    => w_PC,
        o_INST    => w_INST
    );
    
    u_GERADOR_IMM : entity work.gerador_imediato
    port map(
        i_INST    => w_INST,
        o_IMM     => w_IMM
    );

    u_BANCO_REGISTRADORES: entity work.banco_registradores
    port map (    
        i_CLK      => i_CLK,
        i_RSTn     => i_RSTn,
        i_WRena    => w_REG_WRITE,
        i_WRaddr   => w_INST(11 downto 7),
        i_RS1      => w_INST(19 downto 15),
        i_RS2      => w_INST(24 downto 20),
        i_DATA     => w_MUX_MEM2REG,
        o_RS1      => w_RS1,
        o_RS2      => w_RS2
    );

    u_ULA : entity work.ULA
    port map(
        i_A       => w_RS1,
        i_B       => w_ULAb,
        i_F3      => w_INST(14 downto 12),
        i_INST30  => w_INST(30),
        i_ALUOP   => w_ALUOP,
        o_ZERO    => w_ZERO,
        o_ULA     => w_ULA
    );
    
    u_MUX_ULA: entity work.mux21
    port map (
        i_A    => w_RS2,
        i_B    => w_IMM,
        i_SEL  => w_ALU_SRC,
        o_MUX  => w_ULAb
    );
    
    u_MEM_DADOS: entity work.memoria_dados
    port map(
        i_CLK    => i_CLK,
        i_RSTn   => i_RSTn,
        i_ADDR   => w_ULA,
        i_DATA   => w_RS2,
        i_WR     => w_MEM_WRITE,
        i_RD     => w_MEM_READ,
        o_DATA   => w_MEM
    );
    
    u_MUX_MEM2REG: entity work.mux21
    port map (
        i_A    => w_ULA,
        i_B    => w_MEM,
        i_SEL  => w_MEM2REG,
        o_MUX  => w_MUX_MEM2REG
    );
    
    -- Debug signals
    o_INST      <= w_INST;
    o_OPCODE    <= w_INST(6 downto 0);
    o_RD_ADDR   <= w_INST(11 downto 7);
    o_RS1_ADDR  <= w_INST(19 downto 15);
    o_RS2_ADDR  <= w_INST(24 downto 20);
    o_RS1_DATA  <= w_RS1;
    o_RS2_DATA  <= w_RS2;
    o_IMM       <= w_IMM;
    o_ULA       <= w_ULA;
    o_MEM       <= w_MEM;
    
end arch_1;