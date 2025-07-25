library ieee;
use ieee.std_logic_1164.all;
 
entity testbench is
-- empty
end testbench; 

architecture test_1 of testbench is
    -- sinais do testbench
	signal STOP  : BOOLEAN;
	constant PERIOD: TIME := 10 NS;
    
    -- sinais do DUV
	signal w_CLK, w_RSTn	: std_logic;
    signal w_INST 			: std_logic_vector(31 downto 0);
    signal w_OPCODE			: std_logic_vector(6 downto 0);
    signal w_RD_ADDR		: std_logic_vector(4 downto 0);
    signal w_RS1_ADDR 		: std_logic_vector(4 downto 0);
    signal w_RS2_ADDR 		: std_logic_vector(4 downto 0);
    signal W_RS1_DATA 		: std_logic_vector(31 downto 0);
    signal w_RS2_DATA 		: std_logic_vector(31 downto 0);
    signal w_IMM   			: std_logic_vector(31 downto 0);
    signal w_ULA 			: std_logic_vector(31 downto 0);
    signal w_MEM 			: std_logic_vector(31 downto 0);

begin

	-- Connect DUV
  	u_DUV: entity work.RISCV32i 
  			 port map(
             	i_CLK  		=> w_CLK,
    			i_RSTn		=> w_RSTn,
                o_INST  	=> w_INST,
                o_OPCODE	=> w_OPCODE,
    			o_RD_ADDR	=> w_RD_ADDR,
    			o_RS1_ADDR 	=> w_RS1_ADDR,
    			o_RS2_ADDR 	=> w_RS2_ADDR,
    			o_RS1_DATA 	=> w_RS1_DATA,
    			o_RS2_DATA 	=> w_RS2_DATA,
    			o_IMM   	=> w_IMM,
            	o_ULA   	=> w_ULA,
                o_MEM   	=> w_MEM
	);

	-- Gerador de CLOCK
    u_CLK_GEN: process
    begin
      while not STOP loop
          	w_CLK <= '0';
        	wait for PERIOD/2;
        	w_CLK <= '1';
      		wait for PERIOD/2;
      end loop;
      wait;
    end process u_CLK_GEN;

    
  process
    begin
      -- INÍCIO DA SIMULAÇÃO (todas as entradas em zero)
   	  STOP <= FALSE;
      w_RSTn  <= '0';
      wait  for PERIOD;
      
      w_RSTn  <= '1'; --para de resetar
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      wait  for PERIOD; -- cada um desses é o tempo de uma instrução
      
      -- wait for 10*PERIOD; -- é outra maneira de fazer as 10 esperas
      
      -- FIM DA SIMULAÇÃO
      STOP <= TRUE;
      wait;
  end process;
    

end test_1;

 
