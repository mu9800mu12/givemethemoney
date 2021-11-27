import {
  MinimalEventProps, BaseComponent, ViewContext, createElement, AllDayContentArg,
  Seg, isMultiDayRange, DateFormatter, buildSegTimeText, createFormatter, EventRoot, ComponentChildren, RenderHook, getSegAnchorAttrs,
} from '@fullcalendar/common'

const DEFAULT_TIME_FORMAT = createFormatter({
  hour: 'numeric',
  minute: '2-digit',
  meridiem: 'short',
})

export interface ListViewEventRowProps extends MinimalEventProps {
  timeHeaderId: string
  eventHeaderId: string
  dateHeaderId: string
}

export class ListViewEventRow extends BaseComponent<ListViewEventRowProps> {
  render() {
    let { props, context } = this
    let { seg, timeHeaderId, eventHeaderId, dateHeaderId } = props
    let timeFormat = context.options.eventTimeFormat || DEFAULT_TIME_FORMAT

    return (
      <EventRoot
        seg={seg}
        timeText="" // BAD. because of all-day content
        disableDragging
        disableResizing
        defaultContent={() => renderEventInnerContent(seg, context) /* weird */}
        isPast={props.isPast}
        isFuture={props.isFuture}
        isToday={props.isToday}
        isSelected={props.isSelected}
        isDragging={props.isDragging}
        isResizing={props.isResizing}
        isDateSelecting={props.isDateSelecting}
      >
        {(rootElRef, classNames, innerElRef, innerContent, hookProps) => (
          <tr className={['fc-list-event', hookProps.event.url ? 'fc-event-forced-url' : ''].concat(classNames).join(' ')} ref={rootElRef}>
            {buildTimeContent(seg, timeFormat, context, timeHeaderId, dateHeaderId)}
            <td aria-hidden className="fc-list-event-graphic">
              <span className="fc-list-event-dot" style={{ borderColor: hookProps.borderColor || hookProps.backgroundColor }} />
            </td>
            <td ref={innerElRef} headers={`${eventHeaderId} ${dateHeaderId}`} className="fc-list-event-title">
              {innerContent}
            </td>
          </tr>
        )}
      </EventRoot>
    )
  }
}

function renderEventInnerContent(seg: Seg, context: ViewContext) {
  let interactiveAttrs = getSegAnchorAttrs(seg, context)
  return (
    <a {...interactiveAttrs}>
      {/* TODO: document how whole row become clickable */}
      {seg.eventRange.def.title}
    </a>
  )
}

function buildTimeContent(
  seg: Seg,
  timeFormat: DateFormatter,
  context: ViewContext,
  timeHeaderId: string,
  dateHeaderId: string,
): ComponentChildren {
  let { options } = context

  if (options.displayEventTime !== false) {
    let eventDef = seg.eventRange.def
    let eventInstance = seg.eventRange.instance
    let doAllDay = false
    let timeText: string

    if (eventDef.allDay) {
      doAllDay = true
    } else if (isMultiDayRange(seg.eventRange.range)) { // TODO: use (!isStart || !isEnd) instead?
      if (seg.isStart) {
        timeText = buildSegTimeText(
          seg,
          timeFormat,
          context,
          null,
          null,
          eventInstance.range.start,
          seg.end,
        )
      } else if (seg.isEnd) {
        timeText = buildSegTimeText(
          seg,
          timeFormat,
          context,
          null,
          null,
          seg.start,
          eventInstance.range.end,
        )
      } else {
        doAllDay = true
      }
    } else {
      timeText = buildSegTimeText(
        seg,
        timeFormat,
        context,
      )
    }

    if (doAllDay) {
      let hookProps: AllDayContentArg = {
        text: context.options.allDayText,
        view: context.viewApi,
      }

      return (
        <RenderHook<AllDayContentArg> // needed?
          hookProps={hookProps}
          classNames={options.allDayClassNames}
          content={options.allDayContent}
          defaultContent={renderAllDayInner}
          didMount={options.allDayDidMount}
          willUnmount={options.allDayWillUnmount}
        >
          {(rootElRef, classNames, innerElRef, innerContent) => (
            <td ref={rootElRef} headers={`${timeHeaderId} ${dateHeaderId}`} className={['fc-list-event-time'].concat(classNames).join(' ')}>
              {innerContent}
            </td>
          )}
        </RenderHook>
      )
    }

    return (
      <td className="fc-list-event-time">
        {timeText}
      </td>
    )
  }

  return null
}

function renderAllDayInner(hookProps) {
  return hookProps.text
}
