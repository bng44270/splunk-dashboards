<form>
  <label>Apache Requests</label>
  <description></description>
  <fieldset submitButton="false">
    <input type="dropdown" token="sitecn">
      <label>Site Name</label>
      <fieldForLabel>site</fieldForLabel>
      <fieldForValue>site</fieldForValue>
      <search>
        <query>WEBHOSTLIST source="HTLOGS/access_log" |stats count by site | fields - count</query>
        <earliest>rt-1h</earliest>
        <latest>rt</latest>
      </search>
    </input>
  </fieldset>
  <row>
    <panel>
      <title>Requests by $sitecn$ by Host (1h)</title>
      <chart>
        <search>
          <query>WEBHOSTLIST source="HTLOGS/access_log" site="$sitecn$" | stats count by host</query>
          <earliest>rt-1h</earliest>
          <latest>rt</latest>
        </search>
        <option name="charting.chart">bar</option>
        <option name="charting.drilldown">none</option>
      </chart>
    </panel>
  </row>
  <row>
    <panel>
      <title>Requests by Site (1h)</title>
      <chart>
        <search>
          <query>WEBHOSTLIST source="HTLOGS/access_log" | stats count by site</query>
          <earliest>rt-1h</earliest>
          <latest>rt</latest>
        </search>
        <option name="charting.chart">bar</option>
        <option name="charting.drilldown">none</option>
      </chart>
    </panel>
  </row>
  <row>
    <panel>
      <title>Requests by Host (1h)</title>
      <chart>
        <search>
          <query>WEBHOSTLIST source="HTLOGS/access_log" | stats count by host</query>
          <earliest>rt-1h</earliest>
          <latest>rt</latest>
        </search>
        <option name="charting.chart">bar</option>
        <option name="charting.drilldown">none</option>
      </chart>
    </panel>
  </row>
</form>
