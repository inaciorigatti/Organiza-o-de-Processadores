library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ULA is
    port(
        i_A      : in  std_logic_vector(31 downto 0);
        i_B      : in  std_logic_vector(31 downto 0);
        i_F3     : in  std_logic_vector(2 downto 0);
        i_INST30 : in  std_logic;
        i_ALUOP  : in  std_logic_vector(1 downto 0);
        o_ZERO   : out std_logic;
        o_ULA    : out std_logic_vector(31 downto 0)
    );
end ULA;

architecture a1 of ULA is
begin
    process(i_A, i_B, i_F3, i_INST30, i_ALUOP)
    begin
        if (i_ALUOP = "00") then -- For loads/stores (simple add)
            o_ULA <= i_A + i_B;
        elsif (i_ALUOP = "01") then -- For branches (subtract)
            o_ULA <= i_A - i_B;
        else -- For R-type and I-type instructions
            case i_F3 is
                when "000" => -- ADD/SUB
                    if(i_INST30 = '1' and i_ALUOP = "10") then -- SUB
                        o_ULA <= i_A - i_B;
                    else -- ADD/ADDI
                        o_ULA <= i_A + i_B;
                    end if;
                when "100" => -- XOR
                    o_ULA <= i_A xor i_B;
                when "110" => -- OR
                    o_ULA <= i_A or i_B;
                when "111" => -- AND
                    o_ULA <= i_A and i_B;
                when others =>
                    o_ULA <= (others => '0');
            end case;
        end if;
    end process;
    
    -- Zero flag generation
    o_ZERO <= '1' when (i_A - i_B) = X"00000000" else '0';
end a1;