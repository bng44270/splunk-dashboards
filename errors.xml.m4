<form>
  <label>AEM Errors</label>
  <description></description>
  <fieldset submitButton="false">
    <input type="dropdown" token="sitepath">
      <label>Site Path</label>
      <fieldForLabel>hostpath</fieldForLabel>
      <fieldForValue>hostpath</fieldForValue>
      <search>
        <query>HOSTLIST source="CRXDIR/logs/error.log" | rex field=_raw "^.* GET (?&lt;hostpath&gt;\/[a-z]+\/[a-z]+\/).*$" | where not isnull(hostpath) | stats count by hostpath | fields - count</query>
        <earliest>rt-1h</earliest>
        <latest>rt</latest>
      </search>
    </input>
  </fieldset>
  <row>
    <panel>
      <title>Errors by $sitepath$ by Host (1h)</title>
      <chart>
        <search>
          <query>HOSTLIST source="CRXDIR/logs/error.log" "GET $sitepath$" | stats count by host</query>
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
      <title>Errors by Site (1h)</title>
      <chart>
        <search>
          <query>HOSTLIST source="CRXDIR/logs/error.log" | rex field=_raw "^.* GET (?&lt;hostpath&gt;\/[a-z]+\/[a-z]+\/).*$" | where not isnull(hostpath) | stats count by hostpath</query>
          <earliest>rt-1h</earliest>
          <latest>rt</latest>
        </search>
        <option name="charting.chart">bar</option>
        <option name="charting.drilldown">none</option>
      </chart>
    </panel>
  </row>
</form>