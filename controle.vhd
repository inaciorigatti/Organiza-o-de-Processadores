library IEEE;
use IEEE.std_logic_1164.all;

entity controle is
    port (
        i_OPCODE     : in  std_logic_vector(6 downto 0);
        o_ALU_SRC    : out std_logic;
        o_MEM2REG    : out std_logic;
        o_REG_WRITE  : out std_logic;
        o_MEM_READ   : out std_logic;
        o_MEM_WRITE  : out std_logic;
        o_ALUOP      : out std_logic_vector(1 downto 0)
    );
end controle;

architecture arch_controle of controle is
begin
    process(i_OPCODE)
    begin
        -- Default values
        o_ALU_SRC <= '0';
        o_MEM2REG <= '0';
        o_REG_WRITE <= '0';
        o_MEM_READ <= '0';
        o_MEM_WRITE <= '0';
        o_ALUOP <= "00";
        
        case i_OPCODE is
            when "0110011" => -- R-type (ADD, SUB, AND, OR, XOR)
                o_REG_WRITE <= '1';
                o_ALUOP <= "10";
                
            when "0010011" => -- I-type (ADDI, etc.)
                o_ALU_SRC <= '1';
                o_REG_WRITE <= '1';
                o_ALUOP <= "10";
                
            when "0000011" => -- Load (LW)
                o_ALU_SRC <= '1';
                o_MEM2REG <= '1';
                o_REG_WRITE <= '1';
                o_MEM_READ <= '1';
                o_ALUOP <= "00";
                
            when "0100011" => -- Store (SW)
                o_ALU_SRC <= '1';
                o_MEM_WRITE <= '1';
                o_ALUOP <= "00";
                
            when "1100011" => -- Branch (BEQ, etc.)
                o_ALUOP <= "01";
                
            when others => -- Default case
                null;
        end case;
    end process;
end arch_controle;