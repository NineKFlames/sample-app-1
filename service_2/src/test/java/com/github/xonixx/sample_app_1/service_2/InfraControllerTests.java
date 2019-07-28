package com.github.xonixx.sample_app_1.service_2;

import org.junit.Test;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class InfraControllerTests extends ApiTestsBase {

  @Test
  public void testPing() throws Exception {
    mockMvc
        .perform(get("/infra/ping"))
        .andDo(print())
        .andExpect(status().isOk())
        .andExpect(content().string("OK"));
  }
}
